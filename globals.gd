extends Node

signal new_checkpoint

var deaths : int :
	set(value):
		deaths = value
		save('deaths', deaths)
var checkpoint : int :
	set(value):
		var old_checkpoint = checkpoint
		checkpoint = value
		save('checkpoint', checkpoint)
		if old_checkpoint != checkpoint:
			new_checkpoint.emit()
var final_checkpoint : int = 6
var language : String :
	set(value):
		language = value
		TranslationServer.set_locale(language)
		save('language', language, 'config')

func save(param_name : String, value, section : String = 'save') -> void:
	var config = ConfigFile.new()
	var config_path = ProjectSettings.globalize_path('res://save.cfg')
	if config.load(config_path) == OK:
		config.set_value(section, param_name, value)
		config.save(config_path)
