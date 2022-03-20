extends Control


func _ready():
	pass


func _on_Save_pressed():
	Global.save_game(0)


func _on_Load_pressed():
	Global.load_game(0)


func _on_Restart_pressed():
	Global.score = 0
	Global.health = Global.max_health
	Global.lives = Global.max_lives
	Global.level = 1
	get_tree().change_scene("res://Levels/Level1.tscn")
	get_tree().paused = false

func _on_Quit_pressed():
	get_tree().quit()
