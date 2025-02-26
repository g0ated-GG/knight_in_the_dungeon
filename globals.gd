extends Node

signal new_checkpoint

var deaths : int = 0 :
	set(value):
		deaths = value
		save('deaths', deaths)
var checkpoint : int = 0 :
	set(value):
		var old_checkpoint = checkpoint
		checkpoint = value
		save('checkpoint', checkpoint)
		if old_checkpoint != checkpoint:
			new_checkpoint.emit()

func save(param_name : String, value) -> void:
	var config = ConfigFile.new()
	var config_path = ProjectSettings.globalize_path('res://save.cfg')
	if config.load(config_path) == OK:
		config.set_value('save', param_name, value)
		config.save(config_path)
