#!/usr/bin/python3
# coding: utf-8
import base64

encoded = open("encoded.txt", "r").readlines()
decoded = open("decoded.txt", "w")
count = 0

for line in encoded:
	while count != 10:
		line = base64.b64decode(line.encode())
		line = line.decode()
		count += 1
	count = 0
	while count != 10:
		line = base64.b16decode(line.encode())
		line = line.decode()
		count += 1
	count = 0
	line = line + '\n'
	print(line)
	decoded.write(line)