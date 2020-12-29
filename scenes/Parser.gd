extends Node

func load_file(file_name):
	var file = File.new()
	if not file.file_exists("res://files/" + file_name + ".txt"):
		print("MANO SE VC TA VENDO ESSE ERRO É PQ O GODOT É CORNO, MANDA MENSAGEM PRO DANILO")
		return

	file.open("res://files/" + file_name + ".txt", File.READ)
	var returner = []
	var helper = file.get_as_text().split('\n#\n')
	
	for message in helper:
		var helper2 = message.split('\n')
		returner.append(helper2)
	
	return returner
