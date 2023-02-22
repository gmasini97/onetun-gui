extends VBoxContainer

var _index = -1

signal on_yes(index)
signal on_no(index)

func set_params(text, index):
	_index = index
	$Text.text = text
	$Text.text = text

func _on_Yes_pressed():
	emit_signal("on_yes", _index)

func _on_No_pressed():
	emit_signal("on_no", _index)
