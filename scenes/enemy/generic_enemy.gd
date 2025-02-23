class_name GenericEnemy
extends CharacterBody2D

@export var minimal_distance : float = 100.0
@export var speed : float = 200.0
@export var max_attack_distance : float = 400.0

@export var hp : int = 100
@export var hp_max : int = 100

signal hp_changed
signal death

func _ready() -> void:
	hp_changed.connect(sync_hp_bar)

func sync_hp_bar() -> void:
	$Node2D/HP.value = hp
	$Node2D/HP.max_value = hp_max

func _physics_process(_delta: float) -> void:
	if hp == 0:
		return
	var targets = $ViewField.get_overlapping_bodies()
	if not targets.is_empty():
		var player : Node2D = targets[0]
		look_at(player.global_position)
		$Node2D.global_rotation = 0
		if global_position.distance_to(player.global_position) > minimal_distance:
			velocity = global_position.direction_to(player.global_position) * speed
		else:
			velocity = Vector2.ZERO
		move_and_slide()

func damage(points : int) -> void:
	hp = clamp(hp - points, 0, hp_max)
	hp_changed.emit()
	if hp == 0:
		death.emit()
