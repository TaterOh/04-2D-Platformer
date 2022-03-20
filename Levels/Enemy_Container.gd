extends Node2D

func spawn(type, p):
	var Enemy = load("res://Enemies/" + type + ".tscn")
	var enemy = Enemy.instance()
	enemy.position = p
	add_child(enemy)
