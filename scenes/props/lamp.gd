class_name Lamp
extends StaticBody2D

signal state_changed

@export var alt : bool :
	get:
		return $AlternateLight.visible

@export var enabled : bool = true :
	set(state):
		var old_state = enabled
		enabled = state
		$PointLight2D.enabled = state and Globals.light
		$AlternateLight.visible = state and not Globals.light
		$GPUParticles2D.emitting = state and Globals.particles
		if old_state != state:
			state_changed.emit()

func _ready() -> void:
	$SwitchArea2D.body_entered.connect(switch)
	enabled = enabled
	$TipPivot.global_rotation = 0.0

func switch(_target) -> void:
	enabled = !enabled

func show_tip(state : bool) -> void:
	$TipPivot/Tip.visible = state
