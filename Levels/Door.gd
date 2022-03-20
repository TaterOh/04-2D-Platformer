extends Area2D

export var next_level = "Level1.tscn"

func _on_Door_body_entered(body):
	if body.name == "Player":
		Global.level += 1
		get_tree().change_scene("res://Levels/" + next_level)
