extends GenericEnemy

@export var attack_damage : int = 30

func _ready() -> void:
	super._ready()
	$Hand/Sword.body_entered.connect(hit)

func hit(target : Node2D):
	if target is not Arrow:
		target.damage(attack_damage)

func attack() -> void:
	if not $SwordAnimationPlayer.is_playing():
		$SwordAnimationPlayer.play('left_to_right' if [true, false].pick_random() else 'right_to_left')

func idle() -> void:
	$SwordAnimationPlayer.stop()
	$SwordAnimationPlayer.play('RESET')

func damage(points : int) -> void:
	super.damage(points)
	if hp == 0:
		$SwordAnimationPlayer.stop()
		$SwordAnimationPlayer.play('RESET')
