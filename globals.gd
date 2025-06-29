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
var final_checkpoint : int = 6
var language : String :
	set(value):
		language = value
		TranslationServer.set_locale(language)
		save('language', language, 'config')
var ui_scale : float = 1.0 :
	set(value):
		ui_scale = value
		get_tree().root.content_scale_factor = ui_scale
		save('ui_scale', ui_scale, 'config')
var particles : bool = true :
	set(state):
		particles = state
		save('particles', particles, 'config')
var light : bool = true :
	set(state):
		light = state
		save('light', light, 'config')

func get_config_file_path() -> String:
	if OS.has_feature('mobile') or OS.has_feature('web'):
		return 'user://save.cfg'
	else:
		return ProjectSettings.globalize_path('res://save.cfg')

func save(param_name : String, value, section : String = 'save') -> void:
	var config = ConfigFile.new()
	var config_path = get_config_file_path()
	if config.load(config_path) == OK:
		config.set_value(section, param_name, value)
		config.save(config_path)

func restore_default_settings() -> void:
	var config = ConfigFile.new()
	var config_path = get_config_file_path()
	config.set_value('save', 'deaths', 0)
	config.set_value('save', 'checkpoint', 0)
	config.set_value('config', 'language', 'en')
	config.set_value('config', 'ui_scale', 1.0)
	config.set_value('config', 'particles', true)
	config.set_value('config', 'light', true)
	config.save(config_path)
