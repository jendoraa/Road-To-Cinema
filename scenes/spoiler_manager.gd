extends CanvasLayer

@export var spoiler_scene : PackedScene
@export var kecepatan_awal: float = 8.0
@export var kecepatan_minimal: float = 1.5
@export var pengurangan_waktu: float = 0.5

@onready var timer = $Timer

func _ready():
	timer.wait_time = kecepatan_awal
	timer.start()

func _on_timer_timeout():
	var spoiler_ctrl = spoiler_scene.instantiate()
	add_child(spoiler_ctrl)
	var spoiler_baru = spoiler_ctrl.get_node("hp_spoiler")
	spoiler_baru.panggil_event_spoiler()
	
	if timer.wait_time > kecepatan_minimal:
		timer.wait_time -= pengurangan_waktu
