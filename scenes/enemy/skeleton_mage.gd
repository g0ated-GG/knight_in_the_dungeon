extends SkeletonArcher

var fireball_scene = preload('res://scenes/bullet/fireball.tscn')

func shoot_timeout() -> void:
	if shooting:
		if $Bullets.get_child_count() == 0:
			var new_fireball : Fireball = fireball_scene.instantiate()
			new_fireball.caster = self
			get_parent().add_child(new_fireball)
			new_fireball.global_position = global_position + Vector2(64, 0).rotated(global_rotation)
			new_fireball.global_rotation = global_rotation
		else:
			$Bullets.get_child(0).shoot()
