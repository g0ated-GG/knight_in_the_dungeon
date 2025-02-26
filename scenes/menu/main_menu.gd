extends Node2D

func _ready() -> void:
	var config = ConfigFile.new()
	if config.load(ProjectSettings.globalize_path('res://save.cfg')) == OK:
		Globals.deaths = config.get_value('save', 'deaths')
		Globals.checkpoint = config.get_value('save', 'checkpoint')
	if Globals.checkpoint > 0 or Globals.deaths > 0:
		$CanvasLayer/Buttons/ContinueButton.show()

func _on_continue_button_pressed() -> void:
	if Globals.checkpoint in range(0, 2):
		get_tree().change_scene_to_file("res://scenes/world/checkpoint_%d.tscn" % Globals.checkpoint)

func _on_play_button_pressed() -> void:
	Globals.deaths = 0
	Globals.checkpoint = 0
	_on_continue_button_pressed()

func _on_exit_button_pressed() -> void:
	get_tree().quit()
