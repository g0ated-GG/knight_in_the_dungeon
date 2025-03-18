extends Node2D

@export var player : Player
@export var enabled : bool = DisplayServer.is_touchscreen_available() :
	set(state):
		enabled = state
		visible = state

const RELEASED : int = -1
var touch_index : int = RELEASED
var touch_position : Vector2 = Vector2.ZERO
var max_stick_distance : int = 100
var default_stick_rect : Rect2

func setup_default_stick_rect() -> void:
	var stick_rect_position = $Stick.global_position - $Stick/Button.texture_normal.get_size() / 2
	var stick_rect_size = $Stick/Button.texture_normal.get_size()
	default_stick_rect = Rect2(stick_rect_position, stick_rect_size)

func _ready() -> void:
	setup_default_stick_rect()

func _input(event: InputEvent) -> void:
	if not enabled:
		return
	if event is InputEventScreenTouch:
		if touch_index == RELEASED and event.pressed \
		and default_stick_rect.has_point(event.position):
			touch_index = event.index
		if event.index == touch_index:
			if event.pressed:
				touch_position = event.position
			else:
				touch_index = RELEASED
	#if event is InputEventScreenTouch and event.pressed == true:
		#if 
		#stick_position = event.position
	#if event is InputEventScreenTouch and event.pressed == true:
		#$Stick.global_position = event.position - $Stick.texture_normal.get_size() / 2
	#if player:
		#var direction = default_stick_position.direction_to($Stick.position)
		#var distance = default_stick_position.distance_to($Stick.position)
		#if $Stick.is_pressed() and not is_zero_approx(distance):
			#player.direction = direction * clamp(distance * 1.0 / max_stick_position, 0, 1)
			#player.look_at(player.global_position + player.direction * max_stick_position)
		#else:
			#player.direction = Vector2.ZERO

func _physics_process(delta: float) -> void:
	if not enabled:
		return
	if $Stick/Button.is_pressed() and touch_index != RELEASED:
		$Stick.velocity = $Stick.global_position.direction_to(touch_position) * 100
		$Stick.move_and_slide()

func _on_stick_released() -> void:
	$Stick.velocity = Vector2.ZERO
	$Stick.position = Vector2.ZERO
