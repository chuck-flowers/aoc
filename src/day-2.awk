BEGIN {
	points = 0

	code_to_choice["A"] = "rock"
	code_to_choice["B"] = "paper"
	code_to_choice["C"] = "scissors"
	code_to_choice["X"] = "rock"
	code_to_choice["Y"] = "paper"
	code_to_choice["Z"] = "scissors"

	code_to_outcome["X"] = "loss"
	code_to_outcome["Y"] = "tie"
	code_to_outcome["Z"] = "win"

	choice_to_win["rock"] = "scissors"
	choice_to_win["paper"] = "rock"
	choice_to_win["scissors"] = "paper"
	choice_to_loss["rock"] = "paper"
	choice_to_loss["paper"] = "scissors"
	choice_to_loss["scissors"] = "rock"

	choice_points["rock"] = 1
	choice_points["paper"] = 2
	choice_points["scissors"] = 3

	result_points["win"] = 6
	result_points["loss"] = 0
	result_points["tie"] = 3
}

/^[[:alpha:]] [[:alpha:]]$/ {
	opponent_choice = code_to_choice[$1]
	desired_outcome = code_to_outcome[$2]

	required_response = determine_response(opponent_choice, desired_outcome)

	points += score_match(opponent_choice, required_response)
}

END {
	printf("Simulation complete! Scored %d points", points)
}

function determine_response(opponent_choice, desired_outcome) {
	if (desired_outcome == "tie") {
		return opponent_choice
	} else if (desired_outcome == "loss") {
		return choice_to_win[opponent_choice]
	} else {
		return choice_to_loss[opponent_choice]
	}
}

function determine_result(opponent_choice, my_choice) {
	if (opponent_choice == my_choice) {
		return "tie"
	} else if (my_choice == choice_to_win[opponent_choice]) {
		return "loss"
	} else {
		return "win"
	}
}

function score_match(opponent_choice, my_choice) {
	result = determine_result(opponent_choice, my_choice)
	result_score = result_points[result]
	choice_score = choice_points[my_choice]

	return result_score + choice_score
}

