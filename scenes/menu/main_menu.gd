extends Node2D

func _ready() -> void:
	var config = ConfigFile.new()
	var config_loaded : bool = config.load(Globals.get_config_file_path()) == OK
	if not config_loaded:
		Globals.restore_default_settings()
		config_loaded = config.load(Globals.get_config_file_path()) == OK
	if config_loaded:
		Globals.deaths = config.get_value('save', 'deaths')
		Globals.checkpoint = config.get_value('save', 'checkpoint')
		Globals.language = config.get_value('config', 'language')
		Globals.ui_scale = config.get_value('config', 'ui_scale')
		Globals.particles = config.get_value('config', 'particles')
		Globals.light = config.get_value('config', 'light')
		Globals.volume = config.get_value('config', 'volume')
		var language_options : Dictionary[String, int] = {}
		for index in range($CanvasLayer/LanguageOptionButton.item_count):
			language_options[$CanvasLayer/LanguageOptionButton.get_item_text(index)] = index
		$CanvasLayer/LanguageOptionButton.select(language_options[config.get_value('config', 'language')])
	if Globals.checkpoint > 0 or Globals.deaths > 0:
		$CanvasLayer/Buttons/ContinueButton.show()

func _on_continue_button_pressed() -> void:
	var checkpoint = clamp(Globals.checkpoint, 0, Globals.final_checkpoint - 1)
	get_tree().change_scene_to_file("res://scenes/world/checkpoint_%d.tscn" % checkpoint)

func _on_play_button_pressed() -> void:
	Globals.deaths = 0
	Globals.checkpoint = 0
	_on_continue_button_pressed()

func _on_settings_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu/settings.tscn")

func _on_exit_button_pressed() -> void:
	get_tree().quit()

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed('fullscreen'):
		if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

func _on_language_option_button_item_selected(index: int) -> void:
	Globals.language = $CanvasLayer/LanguageOptionButton.get_item_text(index)
