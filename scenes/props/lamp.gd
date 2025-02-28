extends StaticBody2D

signal state_changed

@export var enabled : bool = true :
	set(state):
		var old_state = enabled
		enabled = state
		$PointLight2D.enabled = state
		$GPUParticles2D.emitting = state
		if old_state != state:
			state_changed.emit()

func _ready() -> void:
	$SwitchArea2D.body_entered.connect(switch)

func switch(_target) -> void:
	$PointLight2D.enabled = !$PointLight2D.enabled
	$GPUParticles2D.emitting = !$GPUParticles2D.emitting
