extends Node2D

func _ready() -> void:
	$Root/Gargoyle_f_x1_d1_5s_1.state_changed.connect(secret)
	$Root/Gargoyle_f_x1_d1_5s_2.state_changed.connect(secret)
	$Root/Gargoyle_f_x1_d1_5s_3.state_changed.connect(secret)
	$Root/Gargoyle_f_x1_d1_5s_4.state_changed.connect(secret)
	$"Root/Skeleton archmage".visible = false

func secret(_target) -> void:
	var is_secret_solved : bool = secret_solved()
	if is_secret_solved:
		$Root/Gargoyle_f_x1_d1_5s_1.queue_free()
		$Root/Gargoyle_f_x1_d1_5s_2.queue_free()
		$Root/Gargoyle_f_x1_d1_5s_3.queue_free()
		$Root/Gargoyle_f_x1_d1_5s_4.queue_free()
		$Root/Secret.set_secret_state(is_secret_solved)
		$"Root/Skeleton archmage".alive = true
		$"Root/Skeleton archmage".visible = true

func secret_solved() -> bool:
	return not $Root/Gargoyle_f_x1_d1_5s_1.shooting \
	and not $Root/Gargoyle_f_x1_d1_5s_2.shooting \
	and $Root/Gargoyle_f_x1_d1_5s_3.shooting \
	and $Root/Gargoyle_f_x1_d1_5s_4.shooting
