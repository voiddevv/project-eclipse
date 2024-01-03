extends Node

var data:ConfigFile = ConfigFile.new()
func save():
	data.save("user://save.cfg")
	
func get_data(section:String,value:String,fallback:Variant):
	if not data.has_section_key(section,value): data.set_value(section,value,fallback)
	return data.get_value(section,value,fallback)
func set_data(section:String,key:String,value:Variant):
	data.set_value(section,key,value)
func load():
	var exist:bool = FileAccess.file_exists("user://save.cfg")
	if not exist: save()
	data.load("user://save.cfg")
