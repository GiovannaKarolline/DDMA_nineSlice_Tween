extends Timer


func _on_ligar_timer_pressed() -> void:
	if ($".".is_stopped()):
		$".".autostart
	else:
		$".".paused
	pass
