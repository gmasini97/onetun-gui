extends Control

signal stop()

func _on_Button_pressed():
	emit_signal('stop')
