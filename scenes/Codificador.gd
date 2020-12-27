extends Node

var alphabet = ['a','b','c','d','e','f','g','h','i','j',
				'k','l','m','n','o','p','q','r','s','t',
				'u','v','w','x','w','x','y','z']

var morse = ["._", "_...", "_._.", "_..", ".", ".._.",
			"__.", "....", "..", ".___", "_._",
			"._..", "__", "_.", "___", ".__.",
			"__._", "._.", "...", "._", ".._",
			"..._", ".__", "_.._", "_.__", "__.."]

var morse_nums = ["_____", ".____", "..___", "...__", "...._",
				 ".....", "_....", "__...", "___..", "____."]


func codificar(string, ftype):
	if ftype == 'reverso' or ftype == 'morse':
		return funcref(self, ftype).call_func(string)
	
	var s = ""
	for c in string:
		if c in alphabet:
			s = funcref(self, ftype).call_func(c, s)
		elif c.is_valid_integer():
			if int(c) < 5:
				s += str(int(c)+5)
			else:
				s += str(9-int(c))
		else:
			s += c
	print(s)
	return s

func cesar(c, s):
	s += alphabet[(3+alphabet.find(c)) % 26]
	return s

func atbash(c, s):
	s += alphabet[25-alphabet.find(c)]
	return s

func rot13(c, s):
	s += alphabet[(13+alphabet.find(c)) % 26]
	return s

func reverso(string):
	var s = ""
	var word = ""
	for c in string:
		if c == ' ':
			s += word + " "
			word = ""
		elif c in alphabet or c.is_valid_integer():
			word += c
		else:
			word = word.insert(0, c)
	return s

func polybius(c, s):
	if c == 'z':
		s += 'ee'
	else:
		s += alphabet[alphabet.find(c)%5] + alphabet[alphabet.find(c)/5]
	return s

func morse(string):
	var s = ""
	for c in string:
		if c == ' ':
			s += "/"
		elif s in alphabet:
			s += morse[alphabet.find(c)] + " "
		elif s.is_valid_integer():
			s += morse_nums[int(c)] + " "
		else:
			s += c
	return s
