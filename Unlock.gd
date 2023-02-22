extends Control

signal on_login(password)

func _ready():
	$VB/Password.grab_focus()

func _on_Unlock_pressed():
	emit_signal("on_login", $VB/Password.text)

func _on_OpenDataFolder_pressed():
	Data.show_folder()

func _on_Password_gui_input(event):
	if event.is_action('ui_accept'):
		emit_signal("on_login", $VB/Password.text)
