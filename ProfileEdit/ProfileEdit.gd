extends Control

signal on_save(profile)
signal on_cancel()

var title: LineEdit
var private_key: LineEdit
var public_key: LineEdit
var endpoint: LineEdit
var source_ip: LineEdit
var keepalive: SpinBox
var forwards: TextEdit

func _ready():
	title = $VBEdit/GC/Name
	private_key = $VBEdit/GC/PrivateKey
	public_key = $VBEdit/GC/PublicKey
	endpoint = $VBEdit/GC/Endpoint
	source_ip = $VBEdit/GC/SourceIP
	keepalive = $VBEdit/GC/Keepalive
	forwards = $VBEdit/Forwards

func set_profile(profile: Profile_T):
	title.text = profile.title
	private_key.text = profile.private_key
	public_key.text = profile.public_key
	endpoint.text = profile.endpoint
	source_ip.text = profile.source_ip
	keepalive.value = profile.keep_alive
	forwards.text = profile.forwards

func _on_Save_pressed():
	var p = Profile_T.new()
	p.title = title.text
	p.private_key = private_key.text
	p.public_key = public_key.text
	p.endpoint = endpoint.text
	p.source_ip = source_ip.text
	p.keep_alive = keepalive.value
	p.forwards = forwards.text
	emit_signal("on_save", p)

func _on_Cancel_pressed():
	emit_signal("on_cancel")
