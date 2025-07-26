extends StaticBody2D

@export var number : int = 0
@export var enabled : bool = false :
	set(state):
		enabled = state
		$Sprite2D/FireSprite2D.visible = enabled
		$PointLight2D.enabled = enabled and Globals.light
		$AlternateLight.visible = enabled and not Globals.light

func _ready() -> void:
	$SaveArea2D.body_entered.connect(save)
	if number <= Globals.checkpoint:
		enabled = true
	else:
		enabled = enabled

func save(player : Player):
	if not enabled and Globals.checkpoint < number:
		enabled = true
		Globals.checkpoint = number
		player.hp = player.hp_max
