extends Node2D

func _ready() -> void:
	$Root/Lamp.state_changed.connect(secret)
	$Root/Lamp2.state_changed.connect(secret)
	$Root/Lamp3.state_changed.connect(secret)
	$Root/Lamp4.state_changed.connect(secret)
	$"Root/Giant Mimic".visible = false

func secret() -> void:
	var is_secret_solved : bool = \
		$Root/Lamp.enabled \
		and $Root/Lamp2.enabled \
		and $Root/Lamp3.enabled \
		and not $Root/Lamp4.enabled
	if is_secret_solved:
		$Root/Lamp.queue_free()
		$Root/Lamp2.queue_free()
		$Root/Lamp3.queue_free()
		$Root/Lamp4.queue_free()
		$"Root/Giant Mimic".visible = true
		$Root/Secret.set_secret_state(is_secret_solved)
