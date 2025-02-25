extends SkeletonArcher

@export var attack_damage : int = 5 # 20/s

func _physics_process(_delta: float) -> void:
	var targets = $ViewField.get_overlapping_bodies()
	if not targets.is_empty():
		attack()
	else:
		idle()

func shoot_timeout() -> void:
	if shooting:
		for target in $ViewField.get_overlapping_bodies():
			target.damage(attack_damage)
