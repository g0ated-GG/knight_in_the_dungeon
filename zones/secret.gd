class_name Secret
extends Area2D

@export var hiders : Array[Node2D] = []

func _ready() -> void:
	body_entered.connect(open)
	body_exited.connect(close)

func set_secret_state(is_opened : bool):
	for hider in hiders:
		if hider is StaticBody2D:
			for node in hider.get_children():
				if node is CollisionPolygon2D or node is CollisionShape2D:
					node.set_deferred('disabled', is_opened)
					break
		elif hider is Smoke:
			hider.enabled = !is_opened
		elif hider is GPUParticles2D:
			hider.emitting = !is_opened
		else:
			hider.visible = !is_opened

func open(_target) -> void:
	set_secret_state(true)

func close(_target) -> void:
	set_secret_state(false)
