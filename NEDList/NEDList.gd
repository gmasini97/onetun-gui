extends Control

signal on_new()
signal on_edit(index)
signal on_selected(index)
signal on_unselected()
signal on_delete(index)
signal on_duplicate(index)

var items: ItemList
var _per_item_buttons: Array
var _main_frame: Control
var _confirmation_frame: Control

func _ready():
	items = $VB/Items
	_per_item_buttons.push_back($VB/HB/Duplicate)
	_per_item_buttons.push_back($VB/HB/Delete)
	_per_item_buttons.push_back($VB/HB/Edit)
	_main_frame = $VB
	_confirmation_frame = $VBDel
	
func set_items(itemsArray):
	items.clear()
	for i in itemsArray:
		items.add_item(i)
	_on_Items_nothing_selected()

func show_confirmation(text, index):
	_confirmation_frame.set_params(text, index)
	_confirmation_frame.visible = true
	_main_frame.visible = false

func close_confirmation():
	_confirmation_frame.visible = false
	_main_frame.visible = true

func get_selected_index():
	var selected: PoolIntArray = items.get_selected_items()
	if selected.size() == 1:
		return selected[0]
	return -1

func _on_New_pressed():
	emit_signal("on_new")

func _on_Edit_pressed():
	var selected = get_selected_index()
	if selected != -1:
		emit_signal("on_edit", selected)

func _set_per_item_buttons_enabled(enabled):
	for i in _per_item_buttons:
		i.disabled = not enabled

func _on_Items_item_selected(index):
	_set_per_item_buttons_enabled(true)
	emit_signal("on_selected", index)

func _on_Items_nothing_selected():
	_set_per_item_buttons_enabled(false)
	items.unselect_all()
	emit_signal("on_unselected")

func _on_Delete_pressed():
	var selected = get_selected_index()
	if selected != -1:
		var item_title = items.get_item_text(selected)
		var text = "Are you sure you want to delete %s?" % item_title
		show_confirmation(text, selected)

func _on_Duplicate_pressed():
	var selected = get_selected_index()
	if selected != -1:
		emit_signal("on_duplicate", selected)

func _on_Items_item_activated(index):
	_on_Edit_pressed()

func _on_VBDel_on_yes(index):
	emit_signal("on_delete", index)
	_on_Items_nothing_selected()
	close_confirmation()

func _on_VBDel_on_no(index):
	close_confirmation()
