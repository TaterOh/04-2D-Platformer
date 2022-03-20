extends Node2D

onready var Coin = load("res://Objects/Coin.tscn")

func spawn(p):
	var coin = Coin.instance()
	coin.position = p
	add_child(coin)
