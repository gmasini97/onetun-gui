extends Control

signal on_change(profiles)

var _vb: Control
var _profile_edit: Control

var _profiles: Array

var _editing: int = -1
var _selected: int = -1

func _ready():
	_vb = $VB
	_profile_edit = $ProfileEdit

func set_profiles(profiles):
	_profiles = profiles
	refresh_profiles()

func refresh_profiles():
	var items: Array
	for i in _profiles:
		items.push_back(i.title)
	$VB/NEDList.set_items(items)

func change_to_edit(val):
	_profile_edit.visible = val
	_vb.visible = not val

func _on_NEDList_on_delete(index):
	_profiles.remove(index)
	emit_signal("on_change", _profiles)
	refresh_profiles()

func _on_NEDList_on_new():
	_profiles.push_back(Profile_T.new())
	emit_signal("on_change", _profiles)
	refresh_profiles()

func _on_NEDList_on_edit(index):
	_profile_edit.set_profile(_profiles[index])
	change_to_edit(true)
	_editing = index

func _on_NEDList_on_duplicate(index):
	var p = _profiles[index]
	var p2 = Profile_T.new()
	p2.copy_from(p)
	_profiles.push_back(p2)
	emit_signal("on_change", _profiles)
	refresh_profiles()

func _on_NEDList_on_selected(index):
	$VB/HB/Connect.disabled = false
	_selected = index

func _on_NEDList_on_unselected():
	$VB/HB/Connect.disabled = true
	_selected = -1

func _on_ProfileEdit_on_save(profile):
	if _editing > -1:
		_profiles[_editing] = profile
		emit_signal("on_change", _profiles)
	change_to_edit(false)
	refresh_profiles()

func _on_ProfileEdit_on_cancel():
	change_to_edit(false)

func _on_Connect_pressed():
	if _selected > -1:
		$VB/HB/Connect.disabled = true
		Data.onetun_start(_profiles[_selected])

func _on_Timer_timeout():
	var r = Data.onetun_running()
	$Running.visible = r
	$VB.visible = not r
	$VB/HB/Connect.disabled = false


func _on_Running_stop():
	Data.onetun_kill()
