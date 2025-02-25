class_name Fireball
extends GenericEnemy

@export var explosion_damage : int = 40
@export var caster : GenericEnemy

@export var speed_min : int = 100
@export var speed_max : int = 150

func _ready() -> void:
	$ExplosionArea2D.body_entered.connect(ignition)
	death.connect(explosion)
	speed = randi_range(speed_min, speed_max)

func ignition(target) -> void:
	if target != self and target != caster:
		explosion()

func explosion() -> void:
	alive = false
	$LifeTimer.stop()
	$ExplosionParticles2D.emitting = true
	$AfterLifeTimer.start(1.0)
	for target in $ExplosionArea2D.get_overlapping_bodies():
		if target != self:
			target.damage(explosion_damage)

func _on_life_timer_timeout() -> void:
	self.damage(1)

func _on_after_life_timer_timeout() -> void:
	queue_free()
