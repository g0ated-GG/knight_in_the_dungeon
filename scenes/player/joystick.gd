extends Control

@export var direction : Vector2 = Vector2.ZERO :
	get:
		return ($Stick.global_position - idle_position).normalized()

@export var deflection_margin : float = 100.0

const TOUCH_CANCELLED : int = -1
var idle_position : Vector2
var touch_index : int = TOUCH_CANCELLED
var max_deflection : float

func _ready() -> void:
	idle_position = $Stick.global_position
	max_deflection = $Border.size.x / 2.0
	deflection_margin *= $Border.scale.x

func _input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		if event.pressed and touch_index == TOUCH_CANCELLED:
			if $Stick.get_global_rect().has_point(event.position):
				touch_index = event.index
		if touch_index == event.index and not event.pressed:
			touch_index = TOUCH_CANCELLED
			$Stick.global_position = idle_position
		else:
			return
	if event is InputEventMouseMotion:
		if touch_index != TOUCH_CANCELLED:
			var new_position : Vector2 = get_global_mouse_position() - $Stick.size / 2.0
			var raw_distance : float = idle_position.distance_to(new_position)
			if raw_distance <= (max_deflection + deflection_margin):
				var distance = clamp(raw_distance, 0.0, max_deflection)
				$Stick.global_position = idle_position.move_toward(new_position, distance)
