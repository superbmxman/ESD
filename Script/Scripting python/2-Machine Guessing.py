#!/usr/bin/python3
# coding : utf-8

import random, time

limit = 4000000
mysterious = random.randint(0, limit)

print("Start of hacking ...")
start = time.time()

for bruteforce in range(0, limit):
	if bruteforce == mysterious:
		end = time.time()
		print("Nombre mysterieux", mysterious, "trouvé en", end - start)
