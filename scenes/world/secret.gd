class_name Secret
extends Area2D

@export var hiders : Array[Node2D] = []

func _ready() -> void:
	body_entered.connect(open)
	body_exited.connect(close)

func open(_target) -> void:
	for hider in hiders:
		hider.visible = false

func close(_target) -> void:
	for hider in hiders:
		hider.visible = true
