extends Node

var alphabet = ['a','b','c','d','e','f','g','h','i','j',
				'k','l','m','n','o','p','q','r','s','t',
				'u','v','w','x','w','x','y','z']

var morse = ["._", "_...", "_._.", "_..", ".", ".._.",
			"__.", "....", "..", ".___", "_._",
			"._..", "__", "_.", "___", ".__.",
			"__._", "._.", "...", "._", ".._",
			"..._", ".__", "_.._", "_.__", "__.."]

func cesar(string):
	var s = ""
	for c in string:
		if c in alphabet:
			s += alphabet[(3+alphabet.find(c)) % 26]
		else:
			s += c
	return s

func atbash(string):
	var s = ""
	for c in string:
		if c in alphabet:
			s += alphabet[25-alphabet.find(c)]
		else:
			s += c
	return s

func rot13(string):
	var s = ""
	for c in string:
		if c in alphabet:
			s += alphabet[(13+alphabet.find(c)) % 26]
		else:
			s += c
	return s

func reverso(string):
	var s = ""
	var word = ""
	string = string.insert(string.length(), ' ')
	for c in string:
		if c == ' ':
			s += word + " "
			word = ""
		else:
			word = word.insert(0, c)
	return s

func polybius(string):
	var s = ""
	for c in string:
		if c == 'z':
			s += 'ee'
		elif c in alphabet:
			s += alphabet[alphabet.find(c)%5] + alphabet[alphabet.find(c)/5]
		else:
			s += c
	return s

func morse(string):
	var s = ""
	for c in string:
		if c in alphabet:
			s += morse[alphabet.find(c)] + " "
		elif c == ' ':
			s += "/"
		else:
			s += c
	print(s)
	return s
