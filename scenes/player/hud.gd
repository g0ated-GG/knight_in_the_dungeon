extends Control

@export var player : Player

func _ready() -> void:
	$Death.text = 'Смертей: %d' % Globals.deaths
	if player != null:
		player.hp_changed.connect(sync_hp_bar)
		player.death.connect(defeat)

func sync_hp_bar():
	$HP.value = player.hp
	$HP.max_value = player.hp_max
	$HP/Value.text = '%d / %d' % [player.hp, player.hp_max]

func win():
	show_message('ПОДЗЕМЕЛЬЕ ПРОЙДЕНО', Color.GOLD, 1.5)
	$RestartGameTimer.start()

func defeat():
	show_message('ПОМЕР', Color.RED)
	Globals.deaths += 1
	$Death.text = 'Смертей: %d' % Globals.deaths
	$RestartGameTimer.start()

func _physics_process(_delta: float) -> void:
	$FPS.text = 'FPS: %.1f' % Engine.get_frames_per_second()

func show_message(text : String, color : Color, custom_speed = 1.0):
	$Message.text = text
	$Message.label_settings.font_color = color
	$AnimationPlayer.play('show_message', custom_speed)

func _on_restart_timer_timeout() -> void:
	get_tree().reload_current_scene()

func _on_restart_button_pressed() -> void:
	get_tree().reload_current_scene()

func _on_main_menu_button_pressed() -> void:
	get_tree().change_scene_to_file('res://scenes/menu/main_menu.tscn')

func _on_desktop_button_pressed() -> void:
	get_tree().quit()
