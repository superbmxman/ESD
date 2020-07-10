#!/usr/bin/python3
# coding: utf-8

from sys import argv

if len(argv) < 2:
	print("Specifiez le fichier a rechercher !")
	exit(1)

keyword = ["pass", "pwd", "pswd" "login"]
file = open(argv[1], "r").readlines()
nb = 1

for line in file:
	for word in keyword:
		if word in line:
			print("Password N°", nb, "found : ", line)
			nb += 1