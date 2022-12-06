#!/usr/bin/awk

BEGIN {
	count = 0
}

/^[[:digit:]]+-[[:digit:]]+,[[:digit:]]+-[[:digit:]]+$/ {
	line = $0
	split(line, pairs, ",")

	split(pairs[1], first_pair, "-")
	split(pairs[2], second_pair, "-")

	print "line = " line ", first_pair = " array_to_string(first_pair) ", second_pair = " array_to_string(second_pair)

	if (pair_contains_pair(first_pair, second_pair) || pair_contains_pair(second_pair, first_pair)) {
		count += 1
	}
}

END {
	print count
}

function array_to_string(array) {
	i = 1
	if (i in array) {
		to_return = array[i++]
		while (i in array) {
			to_return = to_return ", " array[i++]
		}

		return "[" to_return "]"
	} else {
		return "[]"
	}
}

function pair_contains_pair(this, other) {
	if (other[1] >= this[1] && this[2] >= other[2]) {
		return 1
	} else {
		return 0
	}
}

