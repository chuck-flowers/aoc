#!/usr/bin/awk

BEGIN {
	split("", pwd_seq)
}

# Change directory
match($0, /^\$ cd (.+)$/, captures) {
	dst_dir = captures[1]

	pwd_seq_length = length(pwd_seq)

	if (dst_dir == "/") {
		delete pwd_seq
	} else if (dst_dir == "..") {
		delete pwd_seq[pwd_seq_length]
	} else {
		pwd_seq[pwd_seq_length + 1] = dst_dir
	}
}

# List content
/^\$ ls/ {
}

# Dir Output
match($0, /^dir ([[:alnum:]]+)$/, captures) {
	dir_name = captures[1]

	pwd_depth = length(pwd_seq)
	pwd_seq[pwd_depth + 1] = dir_name
	types[format_path(pwd_seq)] = "d"
	delete pwd_seq[pwd_depth + 1]
}

# File Output
match($0, /^([[:digit:]]+) (.+)$/, captures) {
	size = captures[1]
	name = captures[2]

	# Make a copy of PWD that includes file name
	delete curr_path
	for (i in pwd_seq) {
		curr_path[i] = pwd_seq[i]
	}
	curr_path[length(pwd_seq) + 1] = name

	types[format_path(curr_path)] = "f"

	for (x = length(curr_path); x > 0; x = length(curr_path)) {
		sizes[format_path(curr_path)] += size
		delete curr_path[x]
	}

	sizes["/"] += size
}

END {
	capacity = 70000000
	used = sizes["/"]
	free = capacity - used
	necessary = 30000000
	to_delete = necessary - free

	for (name in types) {
		type = types[name]
		size = sizes[name]

		if (type == "d" && size > to_delete) {
			printf "Directory %s is a candidate (%d)\n", name, size
			if (perfect_dir == "" || sizes[perfect_dir] > size) {
				printf "Directory %s is better than %s\n", name, perfect_dir
				perfect_dir = name
			}
		}
	}

	print sizes[perfect_dir]
}

function format_path(path)
{
	return "/" join(path, "/")
}

function join(array, sep)
{
	if (!(1 in array))
	{
		return ""
	}

	i = 1
	to_return = array[i++]
	while (i in array)
	{ 
		to_return = to_return sep array[i++]
	}

	return to_return
}

function array_to_string(array)
{
	return "[" join(array, ", ") "]"
}
