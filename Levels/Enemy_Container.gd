extends Node2D

onready var enemies = {
	"Bee": load("res://Enemies/Bee.tscn")
}

func spawn(type, p):
	var Enemy = enemies[type]
	var enemy = Enemy.instance()
	enemy.position = p
	add_child(enemy)
