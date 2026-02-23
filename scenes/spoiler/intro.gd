extends Control

# Daftar urutan cerita
var daftar_cerita : Array[String] = [
	"Finally, I finished all of my assignments!",
	"Now.. I can play on my laptop",
	"Huh, what is this?",
	"OMG! My favorite movie of all time!!",
	"Today??",
	"Oh no, I have to quickly get to the cinema before I get spoiled.",
	"I hope I don’t get spoiled on my way there."
]

var indeks_sekarang : int = 0
@export var next_scene : String = "res://scenes/main.tscn"

@onready var label_teks = $Label # Pastikan namanya sesuai di Scene Tree

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	tampilkan_cerita()

func tampilkan_cerita():
	if indeks_sekarang < daftar_cerita.size():
		label_teks.text = daftar_cerita[indeks_sekarang]
		
		# Efek typewriter (opsional)
		label_teks.visible_ratio = 0
		var tween = create_tween()
		tween.tween_property(label_teks, "visible_ratio", 1.0, 0.5) # Muncul cepat dalam 0.5 detik
		
		# Tunggu 1 detik setelah teks muncul, lalu lanjut otomatis
		await get_tree().create_timer(1.0).timeout
		lanjutkan_cerita()
	else:
		pindah_ke_game()

func lanjutkan_cerita():
	indeks_sekarang += 1
	tampilkan_cerita()

func pindah_ke_game():
	get_tree().change_scene_to_file("res://scenes/main.tscn")
