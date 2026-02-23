extends Control

# Ganti 'Path/Ke/Tombol' dengan path asli tombol home kamu
@onready var home_button = $home

func _ready():
	# Memastikan input mouse benar-benar bebas
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	process_mode = Node.PROCESS_MODE_ALWAYS
	
	if home_button:
		# Putus koneksi lama jika ada (mencegah double connection)
		if home_button.pressed.is_connected(_on_home_pressed):
			home_button.pressed.disconnect(_on_home_pressed)
		home_button.pressed.connect(_on_home_pressed)
	else:
		print("WAWAD: Tombol home tidak ditemukan di path tersebut!")

func _on_home_pressed() -> void:
	if "is_game_over" in GameManager:
		GameManager.is_game_over = false
	get_tree().paused = false
	print("Tombol Home Berhasil Diklik gg!") # Debugging
	get_tree().change_scene_to_file("res://ui/MainMenu.tscn")
	self.queue_free()
