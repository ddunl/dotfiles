push:
	awk '{system("cp " $2 " " $1)}' locations.txt
pull:
	awk '{system("cp " $1 " " $2)}' locations.txt
