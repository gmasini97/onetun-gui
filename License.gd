extends Control

signal on_accept()
signal on_cancel()

const file_path = 'user://onetun-license.txt'

func _ready():
	$LicenseDownload.download_file = file_path
	$LicenseDownload.request('https://raw.githubusercontent.com/aramperes/onetun/master/LICENSE')
	$VB/HB/Yes.disabled = true

func _on_LicenseDownload_request_completed(result, response_code, headers, body):
	var f: File = File.new()
	f.open(file_path, File.READ)
	var content = f.get_as_text(true)
	$VB/License.text = content
	f.close()
	$VB/HB/Yes.disabled = false

func _on_Yes_pressed():
	emit_signal("on_accept")

func _on_No_pressed():
	emit_signal("on_cancel")
