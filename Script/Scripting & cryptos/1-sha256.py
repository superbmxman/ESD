#!/usr/bin/python3
# coding: utf-8
import hashlib


dico = open('/usr/share/wordlists/rockyou.txt', 'rb').readlines()
hash = "77f53fbf8cb6896e23490244ccf7c25ba44578269bf7139e12319ffc7e806eff"

for password in dico:
	clearpass = password
	password = password.rstrip(b'\n')
	password = hashlib.sha256(password)
	password = password.hexdigest()
	if password == hash:
		print("Password found ! : ",clearpass.decode())
		break