.PHONY: today
today: day8

.PHONY: day1
day1:
	awk -f src/day-1.awk data/day-1.txt

.PHONY: day2
day2:
	awk -f src/day-2.awk data/day-2.txt

.PHONY: day3
day3:
	awk -f src/day-3.awk data/day-3.txt

.PHONY: day4
day4:
	awk -f src/day-4.awk data/day-4.txt

.PHONY: day5
day5:
	awk -f src/day-5.awk data/day-5.txt

.PHONY: day6
day6:
	awk -f src/day-6.awk data/day-6.txt

.PHONY: day7
day7:
	awk -f src/day-7.awk data/day-7.txt

.PHONY: day8
day8:
	awk -f src/day-8.awk data/day-8.txt
