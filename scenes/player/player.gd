class_name Player
extends CharacterBody2D

@export var speed = 500.0
@export var hp : int = 100 :
	set(value):
		hp = value
		hp_changed.emit()
@export var hp_max : int = 100 :
	set(value):
		hp_max = value
		hp_changed.emit()
@export var attack_damage : int = 30
@export var alive : bool = true
@export var direction : Vector2 = Vector2.ZERO
@export var touch_control : bool = false
@export var attack : bool = false

@export var god_mode : bool = false

signal hp_changed
signal death

func _ready() -> void:
	randomize()
	$Hand/Sword.body_entered.connect(hit)
	$SuccessDodgeArea.body_entered.connect(success_dodge_reward)

func hit(target : Node2D) -> void:
	if target is not Arrow:
		target.damage(attack_damage)

func success_dodge_reward(_target) -> void:
	heal(5)

func _physics_process(_delta: float) -> void:
	if hp == 0:
		return
	if direction.is_zero_approx():
		direction = Input.get_vector('ui_left', 'ui_right', 'ui_up', 'ui_down')
	if not direction.is_zero_approx():
		velocity = direction * speed
		direction = Vector2.ZERO
		$WalkAnimationPlayer.play('walk')
	else:
		velocity = Vector2.ZERO
		$WalkAnimationPlayer.stop()
		$WalkAnimationPlayer.play('RESET')
	if not touch_control:
		look_at(get_global_mouse_position())
	if not $AnimationPlayer.is_playing():
		if not touch_control and Input.is_action_just_pressed('attack'):
			attack_animation()
		elif touch_control and attack:
			attack_animation()
			attack = false
		if Input.is_action_just_pressed('dodge'):
			$AnimationPlayer.play('dodge')
		if Input.is_action_just_pressed('interact'):
			interact()
	move_and_slide()

func attack_animation() -> void:
	$AnimationPlayer.play('left_to_right' if [true, false].pick_random() else 'right_to_left')

func damage(points : int) -> void:
	hp = clamp(hp - points, 0, hp_max)
	hp_changed.emit()
	if hp == 0 and alive:
		if god_mode:
			hp = hp_max
		else:
			$CollisionShape2D.set_deferred('disabled', true)
			alive = false
			death.emit()
			$WalkAnimationPlayer.active = false

func heal(points : int) -> void:
	hp = clamp(hp + points, 0, hp_max)
	hp_changed.emit()

func interact() -> void:
	var objects_for_interact = $InteractionArea.get_overlapping_bodies()
	for object in objects_for_interact:
		if object is Lamp or object is Gargoyle:
			object.switch(null)

func interactive_object_found(target) -> void:
	if target is Lamp or target is Gargoyle:
		target.show_tip(true)

func interactive_object_lost(target) -> void:
	if target is Lamp or target is Gargoyle:
		target.show_tip(false)
