extends SkeletonArcher

@export var attack_damage : int = 10

func _on_shoot_timer_timeout() -> void:
	if shooting:
		for target in $TeethArea2D.get_overlapping_bodies():
			target.damage(attack_damage)

func attack() -> void:
	super.attack()
	$TeethAnimationPlayer.play('bite')

func idle() -> void:
	super.idle()
	$TeethAnimationPlayer.stop()
