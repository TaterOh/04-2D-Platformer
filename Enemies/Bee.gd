extends KinematicBody2D

var player = null
onready var ray = $RayCast2D

export var look_speed = 100
export var speed = 100
export var damage = 1
export var health = 1

var direction = 1
var velocity = Vector2.ZERO
var tag = "Bee"

func _physics_process(delta):
	player = get_node_or_null("/root/Game/Player_Container/Player")
	if player != null:
		ray.cast_to = ray.to_local(player.global_position)
		var c = ray.get_collider()
		if c:
			velocity = ray.cast_to.normalized()*look_speed
			if c.name == "Player":
				velocity = ray.cast_to.normalized()*speed
			move_and_slide(velocity, Vector2(0,0))


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		body.damage(damage)

func die():
	queue_free()

func damage(d):
	health -= d
	if health <= 0:
		die()
