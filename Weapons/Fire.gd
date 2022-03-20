extends KinematicBody2D

var direction = 1
var velocity = Vector2.ZERO
var speed = 10
var damage = 5

func _physics_process(delta):
	if direction < 0 and !$Sprite.flip_h:
		$Sprite.flip_h = true
	velocity.x += speed*direction
	move_and_slide(velocity, Vector2.UP)

func _on_Timer_timeout():
	queue_free()

func _on_Area2D_body_entered(body):
	if body.get_parent().name == "Enemy_Container":
		body.damage(damage)
		queue_free()
