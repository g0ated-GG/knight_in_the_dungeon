extends Fireball

func _physics_process(_delta: float) -> void:
	if hp == 0 or not alive:
		return
	velocity = Vector2(speed, 0).rotated(rotation)
	move_and_slide()
