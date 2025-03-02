extends Panel

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed('pause'):
		visible = !visible
		get_tree().paused = !get_tree().paused
		if visible:
			$VBoxContainer/ResumeButton.grab_focus()

func _on_resume_button_pressed() -> void:
	visible = false
	get_tree().paused = false

func _on_restart_button_pressed() -> void:
	get_tree().paused = false
	var checkpoint = clamp(Globals.checkpoint, 0, Globals.final_checkpoint - 1)
	get_tree().change_scene_to_file("res://scenes/world/checkpoint_%d.tscn" % checkpoint)

func _on_main_menu_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file('res://scenes/menu/main_menu.tscn')

func _on_desktop_button_pressed() -> void:
	get_tree().paused = false
	get_tree().quit()
