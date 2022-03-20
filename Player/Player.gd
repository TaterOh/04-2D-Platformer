extends KinematicBody2D

onready var SM = $StateMachine
onready var Attack = load("res://Weapons/Fire.tscn")

var velocity = Vector2.ZERO
var jump_power = Vector2.ZERO
var direction = 1
var shoot_speed = 1
var can_shoot = true

export var gravity = Vector2(0,30)

export var move_speed = 20
export var max_move = 300

export var jump_speed = 100
export var max_jump = 1000

export var leap_speed = 100
export var max_leap = 1000

var moving = false
var is_jumping = false
var double_jumped = false
var should_direction_flip = true # wether or not player controls (left/right) can flip the player sprite

func _physics_process(_delta):	
	velocity.x = clamp(velocity.x,-max_move,max_move)
		
	if should_direction_flip:
		if direction < 0 and not $AnimatedSprite.flip_h: $AnimatedSprite.flip_h = true
		if direction > 0 and $AnimatedSprite.flip_h: $AnimatedSprite.flip_h = false
	
	if is_on_floor():
		double_jumped = false
		set_wall_raycasts(true)
	
	if Input.is_action_just_pressed("attack"):
		shoot()

func is_moving():
	if Input.is_action_pressed("left") or Input.is_action_pressed("right"):
		return true
	return false

func move_vector():
	return Vector2(Input.get_action_strength("right") - Input.get_action_strength("left"),1.0)

func _unhandled_input(event):
	if event.is_action_pressed("left"):
		direction = -1
	if event.is_action_pressed("right"):
		direction = 1

func set_animation(anim):
	if $AnimatedSprite.animation == anim: return
	if $AnimatedSprite.frames.has_animation(anim): $AnimatedSprite.play(anim)
	else: $AnimatedSprite.play()

func is_on_floor():
	var fl = $Floor.get_children()
	for f in fl:
		if f.is_colliding():
			return true
	return false

func is_on_right_wall():
	if $Wall/Right.is_colliding():
		return true
	return false

func is_on_left_wall():
	if $Wall/Right.is_colliding():
		return true
	return false

func get_right_collider():
	return $Wall/Right.get_collider()

func get_left_collider():
	return $Wall/Left.get_collider()
	
func set_wall_raycasts(is_enabled):
	$Wall/Left.enabled = is_enabled
	$Wall/Right.enabled = is_enabled

func shoot():
	if can_shoot:
		var attack = Attack.instance()
		attack.position = position
		attack.position.x += 10*direction
		attack.direction = direction
		get_node("/root/Game/Attack_Container").add_child(attack)
		$ShootTimer.wait_time = shoot_speed
		can_shoot = false

func damage(d):
	Global.damage(d)
	if Global.health <= 0:
		die()

func die():
	Global.decrease_lives(1)
	queue_free()


func _on_ShootTimer_timeout():
	can_shoot = true
