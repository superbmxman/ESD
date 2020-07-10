#!/usr/bin/python3
# coding : utf-8

import random

life = 20
mysterious = random.randint(0,30)
answer = input("Guess the number ... : ")

while True:
	if answer == mysterious:
		print("Congratulation !")
		exit(0)
	else:
		if life == 0:
			print("You are DIED")
			print("The number was", mysterious)
			exit(0)
		life -= 1
		answer = int(input("Failed ..., try again : "))
