def valid_trouble(int_arr)
	# This problem boils down to realizing that the comparison in sorting
	# happens in two distinct sets in the array, the even indexed elements are
	# sorted in ascending order and the odd indexed elements are sorted in
	# ascending order, so sort them separately with ruby's built in sorting
	# algorithm and check which index if any fails to sort correctly
	even_indices, odd_indices = int_arr.partition.with_index { |_, i| i.even? }

	even_indices.sort!
	odd_indices.sort!
	trouble_sorted = even_indices.zip(odd_indices).flatten.compact

	trouble_sorted.each_index { |i|
		# Return the index of the element which is followed by an element of smaller value
		if i < trouble_sorted.length - 1 and trouble_sorted[i] > trouble_sorted[i + 1]
			return i
		end
	}

	return "OK"
end

num_arrs = gets.to_i

1.step(to: num_arrs) { |arr_num|
	gets # we ignore the number of elements
	arr = gets.split.map(&:to_i)
	result = valid_trouble(arr)
	puts("Case #" + arr_num.to_s + ": " + result.to_s)
}
