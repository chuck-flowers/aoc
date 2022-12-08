#!/usr/bin/awk

BEGIN {
	FIELDWIDTHS = "4 4 4 4 4 4 4 4 3"

	split("", queues)
	split("", stacks)
}

# Parse this level of initial stack state
/^(\[[[:alpha:]]\]|   )?( (\[[[:alpha:]]\]|   ))*$/ {
	for (i = 1; i <= NF; i++) {
		if ($i != "   " && $i != "    ") {
			item = substr($i, 2, 1)
			queue_enqueue(i, item)
		}
	}
}

# Create the array of stack names
/^( [[:alnum:]] )(  [[:alnum:]])+/ {
	patsplit($0, stack_names, "[[:alnum:]]+")
}

# Convert the aggregate init state to an actual stack
/^\s*$/ {
	for (i in stack_names) {
		stack_name = stack_names[i]
		stack_from_queue(i, stack_name)
	}
}

# Process move instructions
match($0, /^move ([[:digit:]]+) from ([[:alnum:]]+) to ([[:alnum:]]+)$/, capture_groups) {
	# Extract the groups
	quantity = capture_groups[1]
	src = capture_groups[2]
	dst = capture_groups[3]

	stack_move_to(src, dst, quantity)
}

END {
	print_stacks()
}

function print_stacks() {
	max_height = 0
	for (i in stack_names) {
		stack_name = stack_names[i]
		stack_height = length(stacks[stack_name])
		if (stack_height > max_height) {
			max_height = stack_height
		}
	}

	for (i = max_height; i >= 1; i--) {
		for (j = 1; j <= length(stack_names); j++) {
			stack_name = stack_names[j]
			if (i in stacks[stack_name]) {
				printf("[%s] ", stacks[stack_name][i])
			} else {
				printf("    ")
			}
		}

		printf("\n")
	}

	for (i in stack_names) {
		printf " %s  ", stack_names[i]
	}

	printf "\n"
}

function array_to_string(array) {
	if (!(1 in array)) {
		return "[]"
	}

	i = 1
	to_return = "[" array[i++]
	while (i in array) {
		to_return = to_return ", " array[i++]
	}

	return to_return "]"
}

function container_to_name(container) {
	return substr(container, 2, 1)
}

function queue_enqueue(queue_name, item) {
	queue_length = length(queues[queue_name])
	queues[queue_name][queue_length + 1] = item
}

function stack_pop(stack_name) {
	stack_length = length(stacks[stack_name])
	to_return = stacks[stack_name][stack_length]
	delete stacks[stack_name][stack_length]
	return to_return
}

function stack_push(stack_name, item) {
	next_index = length(stacks[stack_name]) + 1
	stacks[stack_name][next_index] = item
}

function stack_move_to(src, dst, count) {
	src_length = length(stacks[src])
	dst_length = length(stacks[dst])

	for (i = 1; i <= count; i++) {
		stacks[dst][dst_length + i] = stacks[src][src_length + i - count]
		delete stacks[src][src_length + i - count]
	}
}

function stack_from_queue(queue_name, stack_name) {
	queue_length = length(queues[queue_name])
	for (i = queue_length; i >= 1; i--) {
		stacks[stack_name][queue_length - i + 1] = queues[queue_name][i]
	}
}

