#!/usr/bin/awk

// {
	DISTINCT_COUNT = 14

	split($0, data, "")
	split("", buffer)

	for (c in data) {
		# Add the character to the buffer
		character = data[c]
		shift_buffer()
		buffer[1] = character

		if (all_characters_distinct()) {
			print c
			break
		}
	}
}

function shift_buffer() {
	last_received_length = DISTINCT_COUNT
	for (i = last_received_length; i > 1; i--) {
		buffer[i] = buffer[i - 1]
	}
}

function all_characters_distinct() {
	if (length(buffer) < DISTINCT_COUNT) {
		return 0
	}

	for (i = 1; i <= DISTINCT_COUNT; i++) {
		ci = buffer[i]
		for (j = i + 1; j <= DISTINCT_COUNT; j++) {
			cj = buffer[j]
			if (ci == cj) {
				return 0
			}
		}
	}

	return 1
}

