extends GenericEnemy

@export var attack_damage : int = 5

func _ready() -> void:
	super._ready()
	$TeethArea2D.body_entered.connect(bite)

func bite(target) -> void:
	if target != self:
		target.damage(attack_damage)

func _physics_process(_delta: float) -> void:
	if hp == 0 or not alive:
		return
	var targets = $ViewField.get_overlapping_bodies()
	if not targets.is_empty():
		var player : Node2D = targets[0]
		look_at(player.global_position)
		$Node2D.global_rotation = 0
		velocity = global_position.direction_to(player.global_position) * speed
		attack()
		move_and_slide()
	else:
		velocity = Vector2.ZERO
		idle()

func attack() -> void:
	super.attack()
	if not $TeethAnimationPlayer.is_playing():
		$TeethAnimationPlayer.play('bite')

func idle() -> void:
	super.idle()
	$TeethAnimationPlayer.stop()
	$TeethAnimationPlayer.play('RESET')

func damage(points : int) -> void:
	hp = clamp(hp - points, 0, hp_max)
	hp_changed.emit()
	if hp == 0 and alive:
		alive = false
		death.emit()
		$MimicAnimationPlayer.play('death')
	if alive:
		check_back()
