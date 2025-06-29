extends Node2D

const TOUCH_SCREEN_SCALE_FACTOR = 2.0

func _ready() -> void:
	var config = ConfigFile.new()
	if config.load(ProjectSettings.globalize_path('res://save.cfg')) == OK:
		Globals.deaths = config.get_value('save', 'deaths')
		Globals.checkpoint = config.get_value('save', 'checkpoint')
		Globals.language = config.get_value('config', 'language')
		var language_options : Dictionary[String, int] = {}
		for index in range($CanvasLayer/LanguageOptionButton.item_count):
			language_options[$CanvasLayer/LanguageOptionButton.get_item_text(index)] = index
		$CanvasLayer/LanguageOptionButton.select(language_options[config.get_value('config', 'language')])
	if Globals.checkpoint > 0 or Globals.deaths > 0:
		$CanvasLayer/Buttons/ContinueButton.show()
	if DisplayServer.is_touchscreen_available():
		get_tree().root.content_scale_factor = TOUCH_SCREEN_SCALE_FACTOR

func _on_continue_button_pressed() -> void:
	var checkpoint = clamp(Globals.checkpoint, 0, Globals.final_checkpoint - 1)
	get_tree().change_scene_to_file("res://scenes/world/checkpoint_%d.tscn" % checkpoint)

func _on_play_button_pressed() -> void:
	Globals.deaths = 0
	Globals.checkpoint = 0
	_on_continue_button_pressed()

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
