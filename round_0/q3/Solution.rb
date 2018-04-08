def choose_plot(num_cells)
	# Create a 1000 x 1000 grid
	plots = Array.new(1000) { Array.new(1000) }
	col = 2
	row = 2
	plots_filled = 0
	num_shots = 0

	while col - 2 < Math.sqrt(num_cells) and num_shots < 1000
		# check that each element has been filled in the specified 3 x 3 square
		while num_shots < 1000 and (
				plots[row - 1][col - 1, 3].include? nil or
				plots[row][col - 1, 3].include? nil or
				plots[row + 1][col - 1, 3].include? nil)
			puts(row.to_s + " " + col.to_s)
			num_shots += 1
			input = gets.split.map(&:to_i)

			# We must have given the program some invalid input
			if input[0] == -1 or input[0] == 0
				return
			end

			# Fill the specified plot
			plots[input[0]][input[1]] = 1
		end

		plots_filled += 9

		if row + 1 < Math.sqrt(num_cells)
			row += 3
		else
			row = 2

			if col + 1 < Math.sqrt(num_cells)
				col += 3
			end
		end
	end
end

$stdout.sync = true

num_tests = gets.to_i

1.step(to: num_tests) { |test|
	num_cells = gets.to_i
	choose_plot(num_cells)
}
