extends Control

var nivel = 0


func _on_timer_timeout() -> void:
	$ProgressBar.value += 2;

	


func _on_adicionar_pressed() -> void:
	$ProgressBar.value += int($LineEdit.text)
	pass


func _on_ligar_timer_pressed() -> void:
	if($LigarTimer/Timer.is_stopped()):
		$LigarTimer/Timer.start()
		$LigarTimer.text = "Parar timer"
	else:
		$LigarTimer/Timer.stop()
		$LigarTimer.text = "Ligar timer"
	


func _on_progress_bar_value_changed(value: float) -> void:
	if ($ProgressBar.value >= $ProgressBar.max_value):
		$ProgressBar.value = 0
		nivel += 1
		$"ProgressBar/Nível".text = str(nivel)
		$ProgressBar.max_value += (0.1 * $ProgressBar.max_value)
	
