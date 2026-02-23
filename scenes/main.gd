extends Node2D

@onready var score_bar = %ScoreBar
@onready var score_timer = $ScoreTimer

func _ready():
	GameManager.score = 0
	GameManager.is_game_over = false
	
	if score_bar:
		score_bar.value = 0
		score_bar.max_value = 100

func _process(_delta):
	if score_bar and not GameManager.is_game_over:
		score_bar.value = GameManager.score
	
	if GameManager.is_game_over and GameManager.score >= 100:
		get_tree().change_scene_to_file("res://ui/MainMenu.tscn")


func _on_score_timer_timeout():
	if not GameManager.is_game_over:
		GameManager.add_score(1)
		
		if GameManager.score >= 100:
			menang()

func menang():
	GameManager.is_game_over = true
	$ScoreTimer.stop()
	
	if has_node("SpoilerManager/Timer"):
		$SpoilerManager/Timer.stop()
	
	if score_bar:
		score_bar.value = 100
