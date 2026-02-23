extends CanvasLayer

func _ready():
	visible = false
	
	var resume_btn = find_child("resume", true, false)
	var quit_btn = find_child("quit", true, false)
	var home_btn = find_child("home", true, false)
	
	if resume_btn: resume_btn.pressed.connect(_on_resume_pressed)
	if quit_btn: quit_btn.pressed.connect(_on_quit_pressed)
	if home_btn: home_btn.pressed.connect(_on_home_pressed)

func _input(event):
	if GameManager.is_game_over:
		return
	if Input.is_action_just_pressed("ui_cancel"): 
		toggle_pause()

func toggle_pause():
	var new_pause_state = !get_tree().paused
	get_tree().paused = new_pause_state
	visible = new_pause_state
	
	if new_pause_state:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _on_resume_pressed():
	toggle_pause()

func _on_home_pressed():
	get_tree().paused = false
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	get_tree().change_scene_to_file("res://ui/MainMenu.tscn")

func _on_quit_pressed():
	get_tree().quit()
