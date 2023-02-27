extends Control

signal on_accept()
signal on_cancel()

func _ready():
	$LicenseDownload.download_file = OSData.license()
	$LicenseDownload.request(OSData.license_download())
	$VB/HB/Yes.disabled = true

func _on_LicenseDownload_request_completed(result, response_code, headers, body):
	var f: File = File.new()
	f.open(OSData.license(), File.READ)
	var content = f.get_as_text(true)
	$VB/License.text = content
	f.close()
	$VB/HB/Yes.disabled = false

func _on_Yes_pressed():
	emit_signal("on_accept")

func _on_No_pressed():
	emit_signal("on_cancel")
