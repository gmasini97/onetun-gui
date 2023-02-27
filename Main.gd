extends Control

func _ready():
	change_interface($P/VB/Unlock)
	_check()

func _check():
	if not Data.has_onetun():
		change_interface($P/VB/License)
		return
	
	if not Data.has_profiles():
		$FirstTimeDialog.popup_centered()
		$FirstTimeDialog.show_modal(true)
		return

func change_interface(interface):
	var ifs: Array = $P/VB.get_children()
	for i in ifs:
		i.visible = i == interface

func show_error(err):
	$ErrorDialog.dialog_text = err
	$ErrorDialog.popup_centered()
	$ErrorDialog.show_modal(true)

func _on_Unlock_on_login(password):
	var p = Data.load_credentials(password)
	if p != null:
		$P/VB/Profiles.set_profiles(p)
		change_interface($P/VB/Profiles)
	else:
		show_error("Wrong password or invaild permissions")

func _on_Profiles_on_change(profiles):
	Data.save_credentials(profiles)

func _on_OnetunDownload_request_completed(result, response_code, headers, body):
	change_interface($P/VB/Unlock)
	Data.post_download()
	_check()

func _on_License_on_accept():
	$OnetunDownload.request('https://github.com/aramperes/onetun/releases/latest/download/onetun.exe')
	change_interface($P/VB/Downloading)

func _on_License_on_cancel():
	change_interface($P/VB/Unlock)
