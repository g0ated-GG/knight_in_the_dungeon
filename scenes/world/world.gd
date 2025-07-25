extends Node2D

const PROCESS_MAX_DISTANCE : float = 4500.0

var player : Player

func _ready() -> void:
	if not Globals.particles:
		disable_particles()
	if not Globals.light:
		disable_light()
	player = get_tree().root.find_children("*", "Player", true, false)[0]

func disable_particles() -> void:
	var nodes = find_children("*", "GPUParticles2D")
	for child in nodes:
		child.emitting = false

func disable_light() -> void:
	var nodes = find_children("*", "PointLight2D")
	for child in nodes:
		child.enabled = false

func _physics_process(_delta: float) -> void:
	for room in get_children():
		if room.has_node('Root'):
			var room_root = room.get_node('Root')
			var distance = player.global_position.distance_to(room_root.global_position)
			if distance > PROCESS_MAX_DISTANCE:
				room.process_mode = Node.PROCESS_MODE_DISABLED
				room.visible = false
			else:
				room.process_mode = Node.PROCESS_MODE_INHERIT
				room.visible = true
