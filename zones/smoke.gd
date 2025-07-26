class_name Smoke
extends GPUParticles2D

@export var enabled : bool = true :
	set(state):
		if Globals.particles:
			enabled = state
		else:
			enabled = false
		emitting = enabled
		$Sparkles.emitting = enabled
