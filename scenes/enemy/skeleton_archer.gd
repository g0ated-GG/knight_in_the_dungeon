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
	if shooting:
		if $Bullets.get_child_count() == 0:
			var new_arrow : GenericBullet = arrow_scene.instantiate()
			$Bullets.add_child(new_arrow)
			new_arrow.archer = self
			new_arrow.global_position = global_position
			new_arrow.global_rotation = global_rotation
			new_arrow.shoot()
		else:
			$Bullets.get_child(0).shoot()
