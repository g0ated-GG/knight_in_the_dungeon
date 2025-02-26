class_name SkeletonArcher
extends GenericEnemy

@export var attack_delay : float = 1.0

var arrow_scene = preload('res://scenes/bullet/arrow.tscn')

var shooting : bool = false

func attack():
	if not shooting:
		$ShootTimer.stop()
		$ShootTimer.start(attack_delay)
		shooting = true

func idle():
	shooting = false

func _on_shoot_timer_timeout() -> void:
	shoot_timeout()

func shoot_timeout() -> void:
	if shooting:
		var new_arrow : Arrow = arrow_scene.instantiate()
		new_arrow.archer = self
		get_parent().add_child(new_arrow)
		new_arrow.global_position = global_position + Vector2(64, 0).rotated(global_rotation)
		new_arrow.global_rotation = global_rotation
		new_arrow.shoot()
		$ArcherAnimationPlayer.play('shoot')
