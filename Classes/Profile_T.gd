extends Object
class_name Profile_T

var title: String = "new profile"
var private_key: String = ""
var public_key: String = ""
var preshared_key: String = ""
var endpoint: String = ""
var source_ip: String = ""
var keep_alive: int = 30
var forwards: String = ""

func get_onetun_params():
	var p: PoolStringArray = [
		"--endpoint-addr", endpoint,
		"--endpoint-public-key", public_key,
		"--private-key", private_key,
		"--source-peer-ip", source_ip,
		"--keep-alive", keep_alive,
		"--preshared-key", preshared_key
	]
	var f = forwards.replace('\n', ' ').replace('\r', ' ')
	p.append_array(f.split(' '))
	return p

func copy_from(p):
	title = p.title
	private_key = p.private_key
	public_key = p.public_key
	preshared_key = p.preshared_key
	endpoint = p.endpoint
	source_ip = p.source_ip
	keep_alive = p.keep_alive
	forwards = p.forwards

func serialize(f: File):
	f.store_pascal_string(title)
	f.store_pascal_string(private_key)
	f.store_pascal_string(public_key)
	f.store_pascal_string(preshared_key)
	f.store_pascal_string(endpoint)
	f.store_pascal_string(source_ip)
	f.store_32(keep_alive)
	f.store_pascal_string(forwards)

func deserialize(f: File):
	title = f.get_pascal_string()
	private_key = f.get_pascal_string()
	public_key = f.get_pascal_string()
	preshared_key = f.get_pascal_string()
	endpoint = f.get_pascal_string()
	source_ip = f.get_pascal_string()
	keep_alive = f.get_32()
	forwards = f.get_pascal_string()
	
