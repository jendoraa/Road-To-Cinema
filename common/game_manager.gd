extends Node

var score: int = 0
var is_game_over: bool = false
var game_over_scene = preload("res://ui/GameOver.tscn") 

func panggil_layar_kalah():
	if is_game_over: return
	is_game_over = true
	var layar_kalah = game_over_scene.instantiate()
	layar_kalah.process_mode = Node.PROCESS_MODE_ALWAYS
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	add_child(layar_kalah)
	layar_kalah.layer = 100
	get_tree().paused = true

func add_score(amount: int):
	if not is_game_over:
		score += amount

func set_game_over():
	panggil_layar_kalah()
