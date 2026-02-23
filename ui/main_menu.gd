extends Control

func _ready() -> void:
	get_tree().paused = false

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/intro.tscn")
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _on_exit_pressed() -> void:
	get_tree().quit()
