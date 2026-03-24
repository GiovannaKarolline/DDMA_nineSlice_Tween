extends Control

func _on_botao_cadastrar_pressed() -> void:
	if $VBoxContainer/InputNome.text == "" || $VBoxContainer/InputNome.text == null:
		$VBoxContainer/labelMensagem.add_theme_color_override("font_color",Color.FIREBRICK)
		$VBoxContainer/labelMensagem.text = "Nome precisa ser preenchido."
	elif $VBoxContainer/InputEmail.text == "" || $VBoxContainer/InputEmail.text == null || not $VBoxContainer/InputEmail.text.contains("@") || not $VBoxContainer/InputEmail.text.contains("."):
		$VBoxContainer/labelMensagem.add_theme_color_override("font_color",Color.FIREBRICK)
		$VBoxContainer/labelMensagem.text = "E-mail inválido."
	elif $VBoxContainer/InputSenha.text.length() < 6:
		$VBoxContainer/labelMensagem.add_theme_color_override("font_color",Color.FIREBRICK)
		$VBoxContainer/labelMensagem.text = "A senha deve ter, pelo menos, 6 caracteres."
	elif $VBoxContainer/InputConfirmarSenha.text != $VBoxContainer/InputSenha.text:
		$VBoxContainer/labelMensagem.add_theme_color_override("font_color",Color.FIREBRICK)
		$VBoxContainer/labelMensagem.text = "Os campos de senha não coincidem."
	else:
		$VBoxContainer/labelMensagem.add_theme_color_override("font_color",Color.FOREST_GREEN)
		$VBoxContainer/labelMensagem.text = "Cadastro efetuado com sucesso!"
	pass # Replace with function body.
