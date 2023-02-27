extends Node
class_name OSData_T

func onetun():
	return get_os_data()['onetun']['executable']
	
func absolute_onetun():
	return ProjectSettings.globalize_path(onetun())
	
func license():
	return get_os_data()['onetun']['license']
	
func license_download():
	return get_os_data()['onetun']['license_download']
	
func download():
	return get_os_data()['onetun']['download']
	
func post_download():
	return get_os_data()['onetun']['post-download']

func get_os_data():
	# "Android", "iOS", "HTML5", "OSX", "Server", "Windows", "UWP", "X11"
	match OS.get_name():
		"OSX":
			return _os_data['macOS']
		"X11":
			return _os_data['linux']
		"Windows", "UWP":
			return _os_data['windows']

const _os_data = {
	"windows": {
		"onetun": {
			"executable": "user://onetun.exe",
			"license": "user://onetun-license.txt",
			"license_download": "https://raw.githubusercontent.com/aramperes/onetun/master/LICENSE",
			"download": "https://github.com/aramperes/onetun/releases/latest/download/onetun.exe",
			"post-download": []
		}
	},
	"linux": {
		"onetun": {
			"executable": "user://onetun",
			"license": "user://onetun-license.txt",
			"license_download": "https://raw.githubusercontent.com/aramperes/onetun/master/LICENSE",
			"download": "https://github.com/aramperes/onetun/releases/latest/download/onetun-linux-amd64",
			"post-download": [
				{"exe": "chmod", "params": ["+x"]}
			]
		}
	},
	"macOS": {
		"onetun": {
			"executable": "user://onetun",
			"license": "user://onetun-license.txt",
			"license_download": "https://raw.githubusercontent.com/aramperes/onetun/master/LICENSE",
			"download": "https://github.com/aramperes/onetun/releases/latest/download/onetun-macos-intel",
			"post-download": [
				{"exe": "chmod", "params": ["+x"]}
			]
		}
	}
}
