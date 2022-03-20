extends Control


func _ready():
	pass


func _on_Restart_pressed():
	Global.score = 0
	Global.health = Global.max_health
	Global.lives = Global.max_lives
	Global.level = 1
	get_tree().change_scene("res://Levels/Level1.tscn")


func _on_Quit_pressed():
	get_tree().quit()
