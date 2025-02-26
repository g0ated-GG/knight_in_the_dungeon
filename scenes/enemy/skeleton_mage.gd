extends SkeletonArcher

var fireball_scene = preload('res://scenes/bullet/fireball.tscn')

func _ready() -> void:
	super._ready()
	death.connect(dispel)

func shoot_timeout() -> void:
	if shooting:
		var new_fireball : Fireball = fireball_scene.instantiate()
		new_fireball.caster = self
		get_parent().add_child(new_fireball)
		new_fireball.global_position = global_position + Vector2(64, 0).rotated(global_rotation)
		new_fireball.global_rotation = global_rotation
		$MageAnimationPlayer.play('cast')

func dispel():
	$GPUParticles2D.emitting = false
