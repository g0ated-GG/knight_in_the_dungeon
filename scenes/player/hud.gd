extends Control

@export var player : Player

func _ready() -> void:
	if player != null:
		player.hp_changed.connect(sync_hp_bar)
		player.death.connect(defeat)

func sync_hp_bar():
	$HP.value = player.hp
	$HP.max_value = player.hp_max

func defeat():
	show_message('ПОМЕР', Color.RED)

func _physics_process(_delta: float) -> void:
	$FPS.text = 'FPS: %.1f' % Engine.get_frames_per_second()

func show_message(text : String, color : Color):
	$Message.text = text
	$Message.label_settings.font_color = color
	$AnimationPlayer.play('show_message')
