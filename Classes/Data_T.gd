extends Node

signal on_error(msg)

var _password: String
const _profiles_path: String = "user://data.dat"

func has_onetun():
	return File.new().file_exists("user://onetun.exe")

func has_profiles():
	return File.new().file_exists(_profiles_path)

func load_credentials(password):
	_password = password
	var profiles = []
	if not has_profiles():
		print_debug("creating profiles.dat")
		save_credentials(profiles)
	else:
		var f = File.new()
		print_debug("loading profiles.dat")
		if f.open_encrypted_with_pass(_profiles_path, File.READ, password) != OK:
			show_error("could not load data file")
			return null
		profiles = deserialize_profiles(f)
		f.close()
	return profiles

func save_credentials(profiles):
	var f = File.new()
	print_debug("saving profiles.dat")
	if f.open_encrypted_with_pass(_profiles_path, File.WRITE, _password) != OK:
		show_error("could not save data file")
		return
	serialize_profiles(f, profiles)
	f.close()

func show_error(msg):
	emit_signal("on_error", msg)

func serialize_profiles(f:File, profiles:Array):
	var l = profiles.size()
	f.store_32(l)
	for i in profiles:
		i.serialize(f)

func deserialize_profiles(f:File):
	var l = f.get_32()
	var profiles = []
	for n in l:
		var p = Profile_T.new()
		p.deserialize(f)
		profiles.push_back(p)
	return profiles

func show_folder():
	var p = ProjectSettings.globalize_path("user://")
	OS.shell_open(p)

func onetun_start(p: Profile_T):
	# "Android", "iOS", "HTML5", "OSX", "Server", "Windows", "UWP", "X11"
	var exe = ""
	match OS.get_name():
		"OSX":
			pass
		"X11":
			pass
		"Windows", "UWP":
			exe = ProjectSettings.globalize_path("user://onetun.exe")
	var params = p.get_onetun_params()
	OS.execute(exe, params, false, [], false, true)
