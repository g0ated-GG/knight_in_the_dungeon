class_name Arrow
extends CharacterBody2D

@export var speed : int = 200
@export var attack_damage : int = 20
@export var shooting : bool = false
@export var archer : Node2D
@export var life_time : float = 7.0

func _ready() -> void:
	$LifeTimer.start(life_time)

func shoot() -> void:
	shooting = true

func _physics_process(delta: float) -> void:
	if not shooting:
		return
	velocity = Vector2(speed * delta, 0).rotated(rotation)
	var collider_info : KinematicCollision2D = move_and_collide(velocity)
	if collider_info:
		var target = collider_info.get_collider()
		if target == self or target == archer:
			return
		if target is Player and not target.get_collision_layer_value(7) or target is GenericEnemy:
			target.damage(attack_damage)
		queue_free()


func _on_life_timer_timeout() -> void:
	queue_free()
