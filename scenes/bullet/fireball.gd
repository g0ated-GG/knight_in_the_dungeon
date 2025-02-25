class_name Fireball
extends GenericEnemy

@export var explosion_damage : int = 40
@export var caster : GenericEnemy

func _ready() -> void:
	death.connect(explosion)

func attack() -> void:
	var targets = $ViewField.get_overlapping_bodies()
	if not targets.is_empty():
		var player : Node2D = targets[0]
		if global_position.distance_to(player.global_position) <= desired_distance:
			self.damage(1)

func explosion() -> void:
	$LifeTimer.stop()
	$ExplosionParticles2D.emitting = true
	$LifeTimer.start(1.0)
	for target in $ExplosionArea2D.get_overlapping_bodies():
		target.damage(explosion_damage)

func _on_life_timer_timeout() -> void:
	self.damage(1)
