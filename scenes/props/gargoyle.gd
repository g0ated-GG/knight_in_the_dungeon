extends StaticBody2D

var arrow_scene = preload('res://scenes/bullet/arrow.tscn')
var fireball_scene = preload('res://scenes/bullet/simple_fireball.tscn')

enum BulletType { ARROW, FIREBALL }

@export var bulletType : BulletType
@export var shooting : bool = false
@export var bullet_speed : int = 200

func _ready() -> void:
	$SwitchArea2D.body_entered.connect(switch)
	if not shooting:
		$AnimationPlayer.play('sleep')

func switch(_target):
	shooting = !shooting
	$AnimationPlayer.stop()
	$AnimationPlayer.play('RESET')
	if not shooting:
		$AnimationPlayer.play('sleep')

# Function for animations
func shoot():
	if not shooting:
		return
	var bullet
	if bulletType == BulletType.ARROW:
		bullet =  arrow_scene.instantiate()
		bullet.archer = self
		bullet.speed = bullet_speed
	else:
		bullet =  fireball_scene.instantiate()
		bullet.caster = self
		bullet.speed_min = bullet_speed
		bullet.speed_max = bullet_speed
	get_parent().add_child(bullet)
	bullet.global_position = global_position + Vector2(64, 0).rotated(global_rotation)
	bullet.global_rotation = global_rotation
	if bulletType == BulletType.ARROW:
		bullet.shoot()
	$AnimationPlayer.stop()
	$AnimationPlayer.play('RESET')
	$AnimationPlayer.play('shoot-arrow' if bulletType == BulletType.ARROW else 'shoot-fireball')
