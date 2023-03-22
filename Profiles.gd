extends Control

signal on_change(profiles)

var _vb: Control
var _profile_edit: Control
var _running: Control

var _profiles: Array

var _editing: int = -1
var _selected: int = -1

func _ready():
	_vb = $VB
	_profile_edit = $ProfileEdit
	_running = $Running

func _set_current_view(ctrl):
	_vb.visible = _vb == ctrl
	_profile_edit.visible = _profile_edit == ctrl
	_running.visible = _running == ctrl

func set_profiles(profiles):
	_profiles = profiles
	refresh_profiles()

func refresh_profiles():
	var items: Array
	for i in _profiles:
		items.push_back(i.title)
	$VB/NEDList.set_items(items)

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
	_set_current_view(_profile_edit)
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
	_set_current_view(_vb)
	refresh_profiles()

func _on_ProfileEdit_on_cancel():
	_set_current_view(_vb)

func _on_Connect_pressed():
	if _selected > -1:
		$VB/HB/Connect.disabled = true
		Data.onetun_start(_profiles[_selected])

func _on_Timer_timeout():
	var r = Data.onetun_running()
	if r:
		_set_current_view(_running)
	else:
		if _running.visible:
			_set_current_view(_vb)
	$VB/HB/Connect.disabled = false


func _on_Running_stop():
	Data.onetun_kill()
