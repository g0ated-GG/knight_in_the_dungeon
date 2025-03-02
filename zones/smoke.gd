class_name Smoke
extends GPUParticles2D

@export var enabled : bool = true :
	set(state):
		enabled = state
		emitting = enabled
		$Sparkles.emitting = enabled
