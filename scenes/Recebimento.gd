extends Control

var cifras = ["CESAR-3", "ATBASH", "ROT13", "REVERSO", "POLYBIUS","MORSE", "NUMEROS"]
var tabelas = ["""A>X  B>Y  C>Z  D>A  E>B  F>C
G>D  H>E  I>F  J>G  K>H
L>I  M>J  N>K  O>L  P>M
Q>N  R>O  S>P  T>Q  U>R
V>S  W>T  X>U  Y>V  Z>W""",
"""A>Z  B>Y  C>X  D>W  E>V  F>U
G>T  H>S  I>R  J>Q  K>P
L>O  M>N  N>M  O>L  P>K
Q>J  R>I  S>H  T>G  U>F
V>E  W>D  X>C  Y>B  Z>A""",
"""A<->N  B<->O  C<->P  D<->Q
E<->R  F<->S  G<->T  H<->U
I<->V  J<->W  K<->X  L<->Y  M<->Z""",
"""Cada palavra está com sua
ordem reversa.
Exemplo:
'Frase exemplo -> ESARF OLPMEXE'
""",
"""A B C D  E    Cada letra corres-
F G H I  J    ponde a uma coorde-
K L M N  O    nada da tabela.
P Q R S  T    Exemplos:
U V W X Y/Z   CA>C. CB>H. DE>X.""",
"""A>._    B>_...  C>_._. D>_..   E>.   F>.._.
G>__.  H>....   I>..    J>.___ K>_._ 
L>._..   M>__  N>_.   O>___ P>.__. 
Q>__._  R>._.  S>...   T>_    U>.._  
V>..._   W>.__  X>_.._ Y>_.__ Z>__..""",
"""0>9  1>3  2>7  3>1  4>5
5>4  6>8  7>2  8>6  9>0
0>_____  1>.____  2>..___  3->...__  
4->...._     5>.....     6>_....    7>__...  
8>___..    9>____."""]
var cifra_atual = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	set_cifra(cifra_atual)


func set_cifra(cifra):
	cifra_atual = cifra
	$TabelaCifra/Label.text = tabelas[cifra]
	$Cifra/Label.text = cifras[cifra]


func _on_LeftCifra_button_up():
	if cifra_atual > 0:
		set_cifra(cifra_atual-1)
	else:
		set_cifra(cifras.size()-1)


func _on_RightCifra_button_up():
	if cifra_atual < cifras.size()-1:
		set_cifra(cifra_atual+1)
	else:
		set_cifra(0)
