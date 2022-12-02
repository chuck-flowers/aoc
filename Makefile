.PHONY: today
today: day2

.PHONY: day1
day1:
	awk -f src/day-1.awk data/day-1.txt

.PHONY: day2
day2:
	awk -f src/day-2.awk data/day-2.txt

