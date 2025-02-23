class_name Player
extends CharacterBody2D

@export var speed = 500.0
@export var hp : int = 100 :
	set(_value):
		hp_changed.emit()
@export var hp_max : int = 100 :
	set(_value):
		hp_changed.emit()
@export var attack_damage : int = 30

signal hp_changed
signal death

func _ready() -> void:
	randomize()
	$Hand/Sword.body_entered.connect(hit)

func hit(target : GenericEnemy):
	target.damage(attack_damage)

func _physics_process(_delta: float) -> void:
	var direction := Input.get_vector('ui_left', 'ui_right', 'ui_up', 'ui_down')
	if direction:
		velocity = direction * speed
	else:
		velocity = Vector2.ZERO
	look_at(get_global_mouse_position())
	if not $AnimationPlayer.is_playing():
		if Input.is_action_just_pressed('attack'):
			$AnimationPlayer.play('left_to_right' if [true, false].pick_random() else 'right_to_left')
		if Input.is_action_just_pressed('dodge'):
			$AnimationPlayer.play('dodge')
	move_and_slide()

func damage(points : int):
	hp = clamp(hp - points, 0, hp_max)
	hp_changed.emit()
	#$CastTimer.stop()
	#$CastTimer.timeout.emit()
	if hp == 0:
		death.emit()

func heal(points : int):
	hp = clamp(hp + points, 0, hp_max)
	hp_changed.emit()
