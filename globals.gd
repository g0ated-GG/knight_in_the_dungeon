extends Node

var deaths : int = 0 :
	set(value):
		deaths = value
		save('deaths', value)
var checkpoint : int = 0 :
	set(value):
		checkpoint = value
		save('checkpoint', value)

func save(param_name : String, value) -> void:
	var config = ConfigFile.new()
	var config_path = ProjectSettings.globalize_path('res://save.cfg')
	if config.load(config_path) == OK:
		config.set_value('save', param_name, value)
		config.save(config_path)
