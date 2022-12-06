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

	split("", group_set)
}

/[[:alpha:]]+/ {
	content = $0
	total_item_count = length(content)
	compartment_item_count = total_item_count / 2

	# Convert the current line into a set of items
	split(content, content_array, "")
	set_from_array(content_array, content_set)

	# Reduce the groups array based on this rucksack's shared items
	if (NR % 3 == 1) {
		copy_array_to(content_set, group_set)
	} else {
		set_intersection(group_set,  content_set, updated_group_set)
		copy_array_to(updated_group_set, group_set)
	}

	# If this is the end of the group, add to priority
	if (NR % 3 == 0) {
		group_priority = 0

		for (i in group_set) {
			group_priority += PRIORITY[group_set[i]]
		}

		priority += group_priority

		split("", group_set)
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
function set_intersection(first_set, second_set, output_set) {
	delete output_set
	i = 1
	for (x in first_set) {
		for (y in second_set) {
			if (first_set[x] == second_set[y]) {
				set_concat(output_set, first_set[x])
			}
		}
	}
}

function set_is_empty(set) {
	if (1 in set) {
		return FALSE
	} else {
		return TRUE
	}
}

function copy_array_to(src, dst) {
	delete dst
	for (i in src) {
		dst[i] = src[i]
	}
}

