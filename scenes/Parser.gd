extends Node

func load_file(file_name):
	if file_name == "finais":
		return [["Sob a luz do amanhecer, soldados oumerianos marcharam sobre Toulann, capital regional de Heimzuck.",
"Mal houve tempo para os aviões decolarem - com um ataque cirúrgico e decisivo, Toulann desmontou como um castelo de cartas.",
"O flanco norte, por fim, estava assegurado. Apesar da guerra ainda não ter se encerrado, estava claro para todos como ela iria acabar.",
"\"É um grande dia para Oumer, soldado. Finalmente, Heimzuck irá pagar por tudo o que fez.\"",
"\"Por Oumer! Pela liberdade!\""],
["Sob a luz do amanhecer, soldados oumerianos marcharam sobre Toulann, capital regional de Heimzuck.",
"Mal houve tempo para os aviões decolarem - com um ataque cirúrgico e decisivo, Toulann desmontou como um castelo de cartas.",
"O flanco norte, por fim, estava assegurado. Apesar da guerra ainda não ter se encerrado, o horizonte finalmente pareceu trazer esperança.",
"...exceto para você. Não demorou muito para oficiais de Oumer descobrirem sobre a morte de Ken Laurson e a identidade de Isaac Mish. Ficou claro quem o apoiou em sua operação.",
"Três dias depois, você estava de costas para a parede - e de frente para um pelotão de fuzilamento.",
"\"Por Oumer! Pela liberdade!\""],
["De região em região, o fronte oumeriano desmoronou sob as forças de Heimzuck.",
"Livros de história futuramente atribuiriam as derrotas a problemas logísticos e de comunicação: suprimentos não foram enviados, e ordens não foram passadas.",
"Quando as tropas chegaram à sua torre, não havia muito a se fazer. Por procedimento padrão, você apagou todas as tabelas de descriptografia... e esperou.",
"\"Depois das cinzas, levanta a Fenix.\""],
["De região em região, o fronte oumeriano desmoronou sob as forças de Heimzuck.",
"Livros de história futuramente atribuiriam as derrotas a problemas logísticos e de comunicação: suprimentos não foram enviados, e ordens não foram passadas.",
"Quando as tropas chegaram à sua torre, um sinal foi enviado para sua máquina: \"Wvklrh wzh xrmazh, ovezmgz z Uvmrc.\"",
"\"Depois das cinzas, levanta a Fenix.\"", 
"Ninguém atirou. Ninguém atacou. Mish cumpriu sua palavra."],
["Sob o céu nublado do horizonte norte, moscas escuras surgiram em volume. Toulann não conseguiu ser capturada.",
"Como um enxame de vespas, centenas de bombas caíram dos céus, desmontando grande parte do avanço oumeriano. Lonpris, Arnheim, Endesberg, Sungarden... todas abaixo.",
"Quando os aviões chegaram à sua torre, não havia mais tempo para escapar. Seu destino já estava selado.",
"Boa noite, operador."],
["Sob o céu nublado do horizonte norte, moscas escuras surgiram em volume. Toulann não conseguiu ser capturada.",
"Como um enxame de vespas, centenas de bombas caíram dos céus, desmontando grande parte do avanço oumeriano. Lonpris, Arnheim, Endesberg, Sungarden... todas abaixo.",
"Quando os aviões chegaram à sua torre, porém... nenhuma bomba caiu. De alguma forma, você foi poupado. Mish cumpriu sua palavra.",
"\"Depois das cinzas, levanta a Fenix.\""],
["Você foi reportado por atividade suspeita por um de seus compatriotas. Não demorou muito até que Laurson encontrou sua mensagem de apoio ao Traidor.",
"Três dias depois, você estava de costas para a parede - e de frente para um pelotão de fuzilamento.",
"\"Por Oumer! Pela liberdade!\""],
["\"Soldado: você foi liberado de seus deveres.\"",
"\"Não podemos continuar esta guerra com um operador que ativamente desobedece nossas ordens.\"",
"\"Volte para sua cidade, garoto. Seu lugar não é aqui.\"",
"\"Por Oumer. Pela liberdade.\""]]

	elif file_name == "General Hop":
		return [["General Hop falando. Soldado, sei que não há muito tempo, então serei breve: estas serão as únicas mensagens descriptografadas que enviarei. Depois, terá de decifrar minha criptografia.",
"Sua máquina possui dois modos: Receber e Enviar. Com Receber, você descriptografa as mensagens de nossos aliados. Com Enviar, você redireciona recursos para acampamentos ou envia ordens criptografadas.",
"No modo de Recebimento, você pode mudar a tabela de descriptografia com as setas. Cada soldado tem sua própria criptografia, então tenha certeza de estar usando a tabela certa.",
"Sobre o Modo Envio, você é responsável por gerenciar os recursos e ordens para mim. Comandantes podem pedir por suprimentos, ou eu posso enviar ordens. É seu trabalho cuidar de tudo isso.",
"Tudo certo? Bem! Alguns dias atrás, nosso espião, Laurson, roubou uma mensagem de ataque criptografada do inimigo. Ele irá enviá-la para você. Veja se consegue descriptografá-la e avisar a base para recuar.",
"Por essa semana, é isso. Hoje, seu horário acaba mais cedo, às 13h. A partir da próxima semana, seu expediente será das 8h até as 20h. Até lá, soldado."]]
	
	elif file_name == "menu":
		return [["AJUDA!",
"Infelizmente, nao ha outra opcao.",
"Guerra nunca muda.",
"Teremos nossa vinganca! Avante, soldados!",
"Eu nao matarei pela guerra de outra pessoa.",
"Temos um Traidor entre nossas tropas. Encontre-o!",
"Eu vou recuar. Isso nao faz sentido.",
"Sem suprimentos ha 2 semanas! Como lutaremos assim?",
"Eu sei. Tambem nao quero fazer isso.",
"Nao temos escolha. Voce entende isso?!",
"Eu vou acabar com essa guerra agora. Voce nao vai me parar.",
"Siga minhas ordens. Nao e muito a se pedir.",
"Cinco semanas. Quatro semanas. Tres semanas...",
"Heimzuck vai pagar. Nao importa o custo.",
"Venha comigo. Mas nao olhe para tras.",
"Ataque as 2 da madrugada. Amanha.",
"Precisamos de 3 ordens de suprimentos, por favor.",
"Eu preciso de TROPAS. ARMAS. MEDICAMENTOS.",
"Esqueca aquele territorio. Precisamos focar em coisas mais importantes.",
"Infelizmente, trago noticias de agouro.",
"Uma morte, tragedia. Mil mortes, estatistica.",
"Nao vou derramar sangue. Nao foi para isso que vim aqui.",
"Incompetentes, todos eles... Mas eu sou diferente.",
"Voce nao enviou nada. Voce forcou nossa mao.",
"Por Oumer! Por liberdade!",
"Isso e surreal... Um mes atras, eu estava do outro lado...",
"Espero ver minha familia em breve.",
"Faz uns dias que nao durmo...",
"Oumer e o nosso lar!",
"E lagrimas derramam por nosso futuro...",
"Nosso sangue nao sera desperdicado. Nao deixarei isso acontecer.",
"Traidor, seu ultimo dia chegou.",
"Tudo isso e justificado. Foram eles que invadiram!",
"Nao vou chorar pela morte de formigas.",
"Se esse for o fim, nao quero morrer sozinho.",
"Parece que cheguei ao fim da linha.",
"Traidor! Eu encontrei o Traidor!"]]
	
	elif file_name == "introd":
		return [["Três anos atrás, a nação de Heimzuck, há tempos devastada, lançou repentinos ataques contra as terras de Oumer, declarando guerra.",
"Três meses atrás, em uma manobra decisiva, Oumer contra-atacou com força em seu fronte norte, avançando sobre a fronteira de Heimzuck e invadindo o país.",
"Três dias atrás, você, um soldado de Oumer, foi designado à uma torre de comunicação na fronteira, tomando parte no momento mais delicado da guerra..."]]
	
#	var file = File.new()
#	if not file.file_exists("res://files/" + file_name + ".txt"):
#		#print("MANO SE VC TA VENDO ESSE ERRO É PQ O GODOT É CORNO, MANDA MENSAGEM PRO DANILO")
#		return
#
#	file.open("res://files/" + file_name + ".txt", File.READ)
#	var returner = []
#	var helper = file.get_as_text().split('\n#\n')
#
#	for message in helper:
#		var helper2 = message.split('\n')
#		returner.append(helper2)
#
#	return returner
