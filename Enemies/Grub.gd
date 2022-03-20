extends KinematicBody2D

onready var right = $Right
onready var left = $Left

export var speed = 75
export var damage = 1
export var health = 2

var direction = 1
var velocity = Vector2.ZERO
var tag = "Grub"

func _physics_process(delta):
	move_and_slide(Vector2(speed*direction, Global.gravity), Vector2.UP)
	if right.is_colliding():
		direction = -1
		$AnimatedSprite.flip_h = true
	elif left.is_colliding():
		direction = 1
		$AnimatedSprite.flip_h = false

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		body.damage(damage)

func die():
	queue_free()

func damage(d):
	health -= d
	if health <= 0:
		die()
