extends StaticBody2D

@export var number : int = 0

func _ready() -> void:
	$SaveArea2D.body_entered.connect(save)

func save(player : Player):
	if Globals.checkpoint < number:
		Globals.checkpoint = number
		player.hp = player.hp_max
