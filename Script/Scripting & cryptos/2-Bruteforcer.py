#!/usr/bin/python3
# coding: utf-8
import hashlib


dico = open('/usr/share/wordlists/rockyou.txt', 'rb').readlines()
hash = "9a5c1f9a4509ba9e14a544ba3b4bfa28"
count = 0

for password in dico:
	clearpass = password
	password = password.rstrip(b'\n')
	while count != 200:
		password = hashlib.md5(password)
		password = password.hexdigest()
		count += 1
		password = password.encode()
	count = 0
	if password.decode() == hash:
		print("Password found ! : ",clearpass.decode())
		break