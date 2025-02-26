class_name GenericEnemy
extends CharacterBody2D

@export var desired_distance : float = 100.0
@export var speed : float = 200.0
@export var hp : int = 100
@export var hp_max : int = 100
@export var alive : bool = true

signal hp_changed
signal death

func _ready() -> void:
	hp_changed.connect(sync_hp_bar)
	sync_hp_bar()
	death.connect(idle)
	$Node2D.global_rotation = 0

func sync_hp_bar() -> void:
	$Node2D/HP.max_value = hp_max
	$Node2D/HP.value = hp
	$Node2D/HP/Value.text = '%d / %d' % [hp, hp_max]

func _physics_process(_delta: float) -> void:
	if hp == 0 or not alive:
		return
	var targets = $ViewField.get_overlapping_bodies()
	if not targets.is_empty():
		var player : Node2D = targets[0]
		look_at(player.global_position)
		$Node2D.global_rotation = 0
		if global_position.distance_to(player.global_position) > desired_distance:
			velocity = global_position.direction_to(player.global_position) * speed
			$AnimationPlayer.play('walk')
		else:
			velocity = Vector2.ZERO
			$AnimationPlayer.stop()
			$AnimationPlayer.play('RESET')
			attack()
		move_and_slide()
	else:
		velocity = Vector2.ZERO
		$AnimationPlayer.stop()
		$AnimationPlayer.play('RESET')
		idle()

func damage(points : int) -> void:
	hp = clamp(hp - points, 0, hp_max)
	hp_changed.emit()
	if hp == 0 and alive:
		alive = false
		death.emit()
		$AnimationPlayer.play('death')
	if alive:
		check_back()

func check_back() -> void:
	if $ViewField.get_overlapping_bodies().is_empty():
		rotate(PI)
		$Node2D.global_rotation = 0

func attack() -> void:
	pass

func idle() -> void:
	pass
