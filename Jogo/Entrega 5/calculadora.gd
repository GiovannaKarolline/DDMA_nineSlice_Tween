extends Control

var numero_atual: String = ""
var numero_anterior: float = 0.0
var operacao_atual: String = ""
var aguardando_segundo_numero: bool = false

@onready var expressao_label = $VBoxContainer/PanelContainer/VBoxContainer/expressao_label
@onready var resultado_label = $VBoxContainer/PanelContainer/VBoxContainer/resultado_label

func _ready() -> void:
	for i in $VBoxContainer/GridContainer.get_children():
		if i is Button:
			i.add_to_group("botoes")
	for i in $VBoxContainer/HBoxContainer.get_children():
		if i is Button:
			i.add_to_group("botoes")

	for botao in get_tree().get_nodes_in_group("botoes"):
		botao.pressed.connect(_on_button_pressed.bind(botao.text))

func _on_button_pressed(texto: String) -> void:
	if texto.is_valid_float():
		digito_pressionado(texto)
	elif texto in ["-","x","+","÷"]:
		operacao_pressionada(texto)
	if texto == "C":
		resetar_calculadora()
	if texto == "=":
		calcular_resultado()

func mudar_cor(cor:Color) -> void:
	var estilo = $VBoxContainer/PanelContainer.get_theme_stylebox("panel").duplicate()
	estilo.bg_color = cor
	$VBoxContainer/PanelContainer.add_theme_stylebox_override("panel",estilo)
	
func digito_pressionado(valor:String)->void:
	if aguardando_segundo_numero == true:
		numero_atual = ""
		aguardando_segundo_numero = false
	numero_atual += valor
	expressao_label.text += valor
	
func operacao_pressionada(operacao:String)->void:
	if numero_atual != "":
		if operacao_atual != "":
			calcular_resultado()
			numero_anterior = resultado_label.text.replace("= ", "").to_float()
		else:
			numero_anterior = numero_atual.to_float()
	operacao_atual = operacao
	aguardando_segundo_numero = true
	expressao_label.text += " " + operacao + " "
	var cores = {
		"+": Color("#4caf50"),
		"-": Color("ffc107"),
		"x": Color("#f44336"),
		"÷": Color("#2196f3")
	}
	if cores.has(operacao):
		mudar_cor(cores[operacao])
	
func calcular_resultado()->void:
	if operacao_atual == "" or numero_atual == "":
		return
	
	var segundo_numero = numero_atual.to_float()
	var resultado = 0.0
	
	if operacao_atual == "÷" and numero_atual.to_float() == 0.0:
		resultado_label.text = "Erro! 🚫"
		return

	match operacao_atual:
		"+": resultado=numero_anterior+segundo_numero
		"-": resultado=numero_anterior-segundo_numero
		"x": resultado=numero_anterior*segundo_numero
		"÷": resultado=numero_anterior/segundo_numero
		
	numero_atual = str(resultado)
	resultado_label.text = "= "+str(resultado)
	
func resetar_calculadora()->void:
	numero_atual = ""
	numero_anterior = 0.0
	operacao_atual = ""
	aguardando_segundo_numero = false
	expressao_label.text = ""
	resultado_label.text = ""
	mudar_cor(Color("#424242"))
