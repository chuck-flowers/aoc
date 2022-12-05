.PHONY: today
today: day3

.PHONY: day1
day1:
	awk -f src/day-1.awk data/day-1.txt

.PHONY: day2
day2:
	awk -f src/day-2.awk data/day-2.txt

day3:
	awk -f src/day-3.awk data/day-3.txt
