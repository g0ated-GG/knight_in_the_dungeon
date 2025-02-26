extends StaticBody2D

func _ready() -> void:
	$SwitchArea2D.body_entered.connect(switch)

func switch(_target) -> void:
	$PointLight2D.enabled = !$PointLight2D.enabled
	$GPUParticles2D.emitting = !$GPUParticles2D.emitting
