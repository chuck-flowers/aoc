#!/usr/bin/awk

BEGIN {
	TRUE = 1
	FALSE = 0

	# The priority of the items
	PRIORITY["a"] = 1
	PRIORITY["b"] = 2
	PRIORITY["c"] = 3
	PRIORITY["d"] = 4
	PRIORITY["e"] = 5
	PRIORITY["f"] = 6
	PRIORITY["g"] = 7
	PRIORITY["h"] = 8
	PRIORITY["i"] = 9
	PRIORITY["j"] = 10
	PRIORITY["k"] = 11
	PRIORITY["l"] = 12
	PRIORITY["m"] = 13
	PRIORITY["n"] = 14
	PRIORITY["o"] = 15
	PRIORITY["p"] = 16
	PRIORITY["q"] = 17
	PRIORITY["r"] = 18
	PRIORITY["s"] = 19
	PRIORITY["t"] = 20
	PRIORITY["u"] = 21
	PRIORITY["v"] = 22
	PRIORITY["w"] = 23
	PRIORITY["x"] = 24
	PRIORITY["y"] = 25
	PRIORITY["z"] = 26
	PRIORITY["A"] = 27
	PRIORITY["B"] = 28
	PRIORITY["C"] = 29
	PRIORITY["D"] = 30
	PRIORITY["E"] = 31
	PRIORITY["F"] = 32
	PRIORITY["G"] = 33
	PRIORITY["H"] = 34
	PRIORITY["I"] = 35
	PRIORITY["J"] = 36
	PRIORITY["K"] = 37
	PRIORITY["L"] = 38
	PRIORITY["M"] = 39
	PRIORITY["N"] = 40
	PRIORITY["O"] = 41
	PRIORITY["P"] = 42
	PRIORITY["Q"] = 43
	PRIORITY["R"] = 44
	PRIORITY["S"] = 45
	PRIORITY["T"] = 46
	PRIORITY["U"] = 47
	PRIORITY["V"] = 48
	PRIORITY["W"] = 49
	PRIORITY["X"] = 50
	PRIORITY["Y"] = 51
	PRIORITY["Z"] = 52
}

/[[:alpha:]]+/ {
	content = $0
	total_item_count = length(content)
	compartment_item_count = total_item_count / 2

	# Convert the first rucksack to an array
	first_str = substr(content, 1, compartment_item_count)
	split(first_str, first_array, "")
	set_from_array(first_array, first_set)

	# Convert the second rucksack to an array
	second_str = substr(content, compartment_item_count + 1, compartment_item_count)
	split(second_str, second_array, "") 
	set_from_array(second_array, second_set)

	# Determine shared items
	set_intersection(first_set, second_set, shared_set)

	# Add the priority of the shared items to the running total
	for (i in shared_set) {
		priority += PRIORITY[shared_set[i]]
	}
}

END {
	print priority
}

function set_contains(array, element) {
	for (i in array) {
		if (array[i] == element) {
			return TRUE
		}
	}

	return FALSE
}

function set_concat(set, element) {
	if (!set_contains(set, element)) {
		i = length(set) + 1
		set[i] = element
	}
}

function set_from_array(array, set) {
	delete set
	for (i in array) {
		set_concat(set, array[i])
	}
}

# Find the items that two arrays have in common
function set_intersection(a_set, b_set, c_set) {
	delete c_set
	i = 1
	for (x in a_set) {
		for (y in b_set) {
			if (a_set[x] == b_set[y]) {
				set_concat(c_set, a_set[x])
			}
		}
	}
}

