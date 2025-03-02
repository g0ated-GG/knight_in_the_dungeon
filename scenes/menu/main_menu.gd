extends Node2D

func _ready() -> void:
	var config = ConfigFile.new()
	if config.load(ProjectSettings.globalize_path('res://save.cfg')) == OK:
		Globals.deaths = config.get_value('save', 'deaths')
		Globals.checkpoint = config.get_value('save', 'checkpoint')
	if Globals.checkpoint > 0 or Globals.deaths > 0:
		$CanvasLayer/Buttons/ContinueButton.show()

func _on_continue_button_pressed() -> void:
	var checkpoint = clamp(Globals.checkpoint, 0, Globals.final_checkpoint - 1)
	get_tree().change_scene_to_file("res://scenes/world/checkpoint_%d.tscn" % checkpoint)

func _on_play_button_pressed() -> void:
	Globals.deaths = 0
	Globals.checkpoint = 0
	_on_continue_button_pressed()

func _on_exit_button_pressed() -> void:
	get_tree().quit()

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed('fullscreen'):
		if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
