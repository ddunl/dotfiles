

OS := $(shell uname)

ifeq ($(OS),Darwin)
	LOCFILE = mac_locations.txt
else
	LOCFILE = locations.txt
endif


install:
	awk '{system("cp "$$2" "$$1)}' $(LOCFILE)
pull:
	awk '{system("cp "$$1" "$$2)}' $(LOCFILE)
