extends Node2D

export var spawn_location = Vector2(100, 300)
onready var Player = load("res://Player/Player.tscn")

func _physics_process(_delta):
	var player = get_node_or_null("Player")
	if player == null:
		spawn(spawn_location)

func spawn(p):
	var player = Player.instance()
	player.position = p
	player.name = "Player"
	Global.health = Global.max_health
	add_child(player)
