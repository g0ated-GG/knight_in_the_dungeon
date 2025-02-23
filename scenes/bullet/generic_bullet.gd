class_name GenericBullet
extends CharacterBody2D

@export var archer : Node2D
@export var speed : float = 200.0
@export var max_distance : float = 2000.0
@export var damage : int = 20

var begin_point : Vector2

func shoot():
	global_rotation = archer.global_rotation
	begin_point = global_position
	get_parent().remove_child(self)
	get_parent().get_parent().add_child(self)

func _physics_process(delta: float) -> void:
	if get_parent().name != 'Bullets' and begin_point != null:
		if begin_point.distance_to(global_position) <= max_distance:
			velocity = Vector2(speed, 0).rotated(rotation)
			var collision : KinematicCollision2D = move_and_collide(velocity * delta)
			if collision:
				var collider = collision.get_collider()
				if collider != self:
					if collider is Player or collider is GenericEnemy:
						collider.damage(damage)
					return_to_pool()
		else:
			return_to_pool()

func return_to_pool():
	var bullets : Node2D = archer.get_node('Bullets')
	if bullets != null:
		global_position = archer.global_position
		global_rotation = archer.global_rotation
		get_parent().remove_child(self)
		bullets.add_child(self)
