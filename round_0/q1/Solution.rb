def cnt_pwr(max_pwr, cmd_seq)
	if cmd_seq.count('S') > max_pwr
		return "IMPOSSIBLE"
	end

	charge_pwrs = []
	is_first_charge = true
	is_charging = false
	cur_pwr = 0

	cmd_seq.each_char { |cmd|
		if cmd == 'C'
			# if this is the first charge command in a sequence
			if is_first_charge
				if charge_pwrs.length > 0
					charge_pwrs.push(charge_pwrs.last + 1)
				else
					charge_pwrs.push(1)
				end

				is_charging = true
				is_first_charge = false
			else
				charge_pwrs[-1] += 1
			end
		elsif cmd == 'S'
			# ensure that the first S following a sequence of Cs does not get
			# double counted
			if charge_pwrs.length > 0
				if not is_charging
					charge_pwrs.push(charge_pwrs.last)
				end
			else
				charge_pwrs.push(0)
			end

			cur_pwr += 2 ** charge_pwrs.last

			is_charging = false
			is_first_charge = true
		end
	}

	if cmd_seq.split('').last == 'C'
		charge_pwrs.pop
	end

	num_mvs = 0

	while cur_pwr > max_pwr
		# the largest charge is going to be the last one, so remove it
		i = charge_pwrs.length - 1

		# find the last location in charge_pwrs that is incremented by a charge
		while i > 0 and charge_pwrs[i] - charge_pwrs[i - 1] == 0
			i -= 1
		end

		# Update to indicate we moved a charge
		num_mvs += 1
		charge_pwrs[i] -= 1

		# if the last charge of a sequence of charges has been moved, remove
		# the grouping from the charge_pwrs array
		if (i == 0 and charge_pwrs[i] < 0) or (i > 0 and charge_pwrs[i] < charge_pwrs[i - 1])
			charge_pwrs.pop
		end

		cur_pwr = charge_pwrs.inject(0) { |sum, x| sum + 2 ** x }
	end

	return num_mvs
end

num_cmds = gets.to_i

1.step(to: num_cmds) { |cmd_num|
	max_pwr, pwr_cmd = gets.split
	result = cnt_pwr(max_pwr.to_i, pwr_cmd)
	puts("Case #" + cmd_num.to_s + ": " + result.to_s)
}
