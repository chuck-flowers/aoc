BEGIN {
	top_three_elves[1] = 0;
	top_three_elves[2] = 0;
	top_three_elves[3] = 0;
	current_calorie_sum = 0;
}

/^[0-9]+$/ {
	current_calorie_sum += $1;
}

/^$/ {
	if (top_three_elves[1] < current_calorie_sum) {
		top_three_elves[1] = current_calorie_sum;
		asort(top_three_elves);
	}

	current_calorie_sum = 0;
}

END {
	print top_three_elves[1] + top_three_elves[2] + top_three_elves[3];
}

