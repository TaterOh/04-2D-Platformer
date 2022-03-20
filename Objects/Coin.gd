extends Area2D

export var score = 5

func _on_Coin_body_entered(body):
	if body.name == "Player":
		Global.increase_score(score * Global.level)
		queue_free()
