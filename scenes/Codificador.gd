extends Node

var alphabet = ['a','b','c','d','e','f','g','h','i','j',
				'k','l','m','n','o','p','q','r','s','t',
				'u','v','w','x','w','x','y','z']

var morses = ["._", "_...", "_._.", "_..", ".", ".._.",
			"__.", "....", "..", ".___", "_._",
			"._..", "__", "_.", "___", ".__.",
			"__._", "._.", "...", "_", ".._",
			"..._", ".__", "_.._", "_.__", "__.."]

var morse_nums = ["_____", ".____", "..___", "...__", "...._",
				 ".....", "_....", "__...", "___..", "____."]


func codificar(string, ftype):
	if ftype == "nada":
		return string
	
	string = string.to_lower()
	
	if ftype == "reverso" or ftype == "morse":
		return funcref(self, ftype).call_func(string)
	
	var s = ""
	for c in string:
		if c in alphabet:
			s = funcref(self, ftype).call_func(c, s)
		elif c.to_lower() in alphabet:
			s = funcref(self, ftype).call_func(c.to_lower(), s, true)
		elif c.is_valid_integer():
			if int(c) < 5:
				s += str(9-int(c))
			else:
				s += str(int(c)-5)
		else:
			s += c
	return s

func cesar3(c, s, caps = false):
	if caps:
		s += alphabet[(3+alphabet.find(c)) % 26].to_lower()
	else:
		s += alphabet[(3+alphabet.find(c)) % 26]
	return s

func cesar7(c, s, caps = false):
	if caps:
		s += alphabet[(7+alphabet.find(c)) % 26].to_lower()
	else:
		s += alphabet[(7+alphabet.find(c)) % 26]
	return s

func atbash(c, s, caps = false):
	if caps:
		s += alphabet[25-alphabet.find(c)].to_lower()
	else:
		s += alphabet[25-alphabet.find(c)]
	return s

func reverso(string):
	var s = ""
	var word = ""
	for c in string:
		if c in alphabet or c.is_valid_integer():
			word = word.insert(0, c)
		else:
			s += word + c
			word = ""
	return s

func polybius(c, s, _caps = false):
	if c == 'z' or c == 'Z':
		s += 'ee'
	else:
		s += alphabet[alphabet.find(c)%5] + alphabet[alphabet.find(c)/5]
	return s

func morse(string):
	var s = ""
	for c in string:
		if c == ' ':
			s += "/ "
		elif c in alphabet:
			s += morses[alphabet.find(c)] + " "
		elif c.to_lower() in alphabet:
			s += morses[alphabet.find(c.to_lower())] + " "
		elif c.is_valid_integer():
			s += morse_nums[int(c)] + " "
		else:
			s += c + " "
	return s
