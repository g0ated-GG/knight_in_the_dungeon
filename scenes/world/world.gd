extends Node2D

func _ready() -> void:
	if not Globals.particles:
		disable_particles()
	if not Globals.light:
		disable_light()

func disable_particles() -> void:
	var nodes = find_children("*", "GPUParticles2D")
	for child in nodes:
		child.emitting = false

func disable_light() -> void:
	var nodes = find_children("*", "PointLight2D")
	for child in nodes:
		child.enabled = false
