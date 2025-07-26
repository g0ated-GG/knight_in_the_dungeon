extends Area2D

@export var attack_damage : int = 5 # 20/s

func _ready() -> void:
	$CollisionShape2D/PointLight2D.enabled = Globals.light
	$AlternateLight.visible = not Globals.light

func damage() -> void:
	for target in get_overlapping_bodies():
		target.damage(attack_damage)
