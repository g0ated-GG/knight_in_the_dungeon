extends Node2D

func _ready() -> void:
	$Root/Area2D.body_entered.connect(func(_target): enable_row(1))
	$Root/Area2D2.body_entered.connect(func(_target): enable_row(2))
	$Root/Area2D3.body_entered.connect(func(_target): enable_row(3))
	$Root/Area2D4.body_entered.connect(func(_target): enable_row(4))
	$Root/Area2D5.body_entered.connect(func(_target): enable_row(5))
	$Root/Area2D6.body_entered.connect(func(_target): enable_row(6))

func enable_row(number : int) -> void:
	get_node('Root/Lamp%d' % (number * 2 - 1)).enabled = true
	get_node('Root/Lamp%d' % (number * 2)).enabled = true
