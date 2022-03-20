extends Node

var score = 0
var lives = 3
var max_lives = 3
var health = 5
var max_health = 5
var level = 1

var saves = [
	"user://game-data_0.json"
]

func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS

func _unhandled_input(event):
	if event.is_action_pressed("menu"):
		var menu = get_node_or_null("/root/Game/UI/Menu")
		if menu != null:
			var p = get_tree().paused
			if p:
				menu.hide()
				get_tree().paused = false
			else:
				menu.show()
				get_tree().paused = true

func increase_score(s):
	score += s

func damage(d):
	health -= d

func heal(h):
	health += h

func increase_lives(l):
	lives += l

func decrease_lives(l):
	lives -= l
	if lives <= 0:
		get_tree().change_scene("res://Levels/Game_Over.tscn")

func load_save_level(data):
	score = data["score"]
	lives = data["lives"]
	health = data["health"]
	level = data["level"]
	
	get_tree().change_scene("res://Levels/Level" + var2str(level) + ".tscn")
	call_deferred("load_save_data", data)

func get_save_data():
	var data = {
		"score":score,
		"lives":lives,
		"health":health,
		"level":level,
		"player":"",
		"enemies":[],
		"coins":[]
	}
	var player = get_node_or_null("/root/Game/Player_Container/Player")
	if player != null:
		data["player"] = var2str(player.position)
	var enemies = get_node("/root/Game/Enemy_Container").get_children()
	for e in enemies:
		var temp = {"type":e.tag, "position":var2str(e.position)}
		data["enemies"].append(temp)
	var coins = get_node("/root/Game/Coin_Container").get_children()
	for c in coins:
		data["coins"].append(var2str(c.position))
	return data

func load_save_data(data):	
	var menu = get_node_or_null("/root/Game/UI/Menu")
	if menu != null:
		menu.show()
	
	if data["player"] != "":
		var player = get_node_or_null("/root/Game/Player_Container/Player")
		if player != null:
			player.name = "To_Delete"
			player.queue_free()
		get_node("/root/Game/Player_Container").spawn(str2var(data["player"]))
	
	var enemy_c = get_node("/root/Game/Enemy_Container")
	for e in enemy_c.get_children():
		e.queue_free()
	for e in data["enemies"]:
		enemy_c.spawn(e["type"], str2var(e["position"]))
	
	var coin_c = get_node("/root/Game/Coin_Container")
	for c in coin_c.get_children():
		c.queue_free()
	for c in data["coins"]:
		coin_c.spawn(str2var(c.position))

func save_game(which_file):
	var file = File.new()
	var data = get_save_data()
	file.open(saves[which_file], File.WRITE)
	file.store_string(to_json(data))
	file.close()

func load_game(which_file):
	var file = File.new()
	if file.file_exists(saves[which_file]):
		file.open(saves[which_file], File.READ)
		var data = parse_json(file.get_as_text())
		file.close()
		if typeof(data) == TYPE_DICTIONARY:
			load_save_data(data)
		else:
			print("Corrupted data")
	else:
		print("No save data")
