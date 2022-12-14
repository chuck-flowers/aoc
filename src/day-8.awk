#!/usr/bin/awk

BEGIN {
	row_size = 0
	col_size = 0
}

/^[[:digit:]]+$/ {
	row_size++
	split($0, row, "")
	for (i in row) {
		height = row[i]
		height_grid[row_size][i] = height
	}

	if (row_size == 1) {
		col_size = length(row)
	}
}

END {
	printf "Scanning grid (%dx%d)\n", row_size, col_size

	# From the left
	for (r = 1; r <= row_size; r++) {
		max = -1
		for (c = 1; c <= col_size; c++) {
			height = height_grid[r][c]
			if (height > max) {
				max = height
				visibility_grid[r][c] = 1
			}
		}
	}

	# From the right
	for (r = 1; r <= row_size; r++) {
		max = -1
		for (c = col_size; c > 0; c--) {
			height = height_grid[r][c]
			if (height > max) {
				max = height
				visibility_grid[r][c] = 1
			}
		}
	}
	
	# From the top
	for (c = 1; c <= col_size; c++) {
		max = -1
		for (r = 1; r <= row_size; r++) {
			height = height_grid[r][c]
			if (height > max) {
				max = height
				visibility_grid[r][c] = 1
			}
		}
	}

	# From the bottom
	for (c = 1; c <= col_size; c++) {
		max = -1
		for (r = row_size; r > 0; r--) {
			height = height_grid[r][c]
			if (height > max) {
				max = height
				visibility_grid[r][c] = 1
			}
		}
	}

	# Count the number of visible trees
	visible_tree_count = 0
	for (r = 1; r <= row_size; r++) {
		for (c = 1; c <= col_size; c++) {
			if (visibility_grid[r][c] == 1) {
				visible_tree_count++
			}
		}
	}

	printf "There are %d visible trees\n", visible_tree_count

	max_score = -1
	for (r = 1; r <= row_size; r++) {
		for (c = 1; c <= col_size; c++) {
			score = calculate_scenic_score(r, c)
			if (max_score < score) {
				max_score = score
			}
		}
	}

	printf "The best scenic score is %d\n", max_score
}

function calculate_scenic_score(r, c) {
	threshold_height = height_grid[r][c]

	# Look left
	left = 0
	for (i = c - 1; i >= 1; i--) {
		height = height_grid[r][i]
		left++
		if (height >= threshold_height) {
			break;
		}
	}

	# Look right
	right = 0
	for (i = c + 1; i <= col_size; i++) {
		height = height_grid[r][i]
		right++
		if (height >= threshold_height) {
			break;
		}
	}

	# Look up
	up = 0
	for (i = r - 1; i >= 1; i--) {
		height = height_grid[i][c]
		up++
		if (height >= threshold_height) {
			break;
		}
	}
	
	# Look down
	down = 0
	for (i = r + 1; i <= row_size; i++) {
		height = height_grid[i][c]
		down++
		if (height >= threshold_height) {
			break;
		}
	}

	return left * right * up * down
}
