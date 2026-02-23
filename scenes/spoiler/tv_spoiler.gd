extends StaticBody2D

# Variable status
var player_ref: Node2D = null
var player_in_radius = false
var spoiler = false # Status GAGAL (timeout)

@onready var lifetime_timer = $LifetimeTimer
@onready var tombol_klik = $Button
@onready var bar_waktu = $SpoilerBar

func _ready():
	visible = true
	tombol_klik.visible = false
	bar_waktu.visible = false
	
	lifetime_timer.timeout.connect(_on_lifetime_timeout)
	if tombol_klik:
		tombol_klik.pressed.connect(berhasil_ditekan)

func _process(_delta):
	if bar_waktu.visible and not lifetime_timer.is_stopped():
		var sisa_persen = (lifetime_timer.time_left / lifetime_timer.wait_time) * 100
		bar_waktu.value = sisa_persen
		
		if sisa_persen < 35:
			bar_waktu.tint_progress = Color.RED
		else:
			bar_waktu.tint_progress = Color.GREEN

func _on_lifetime_timeout():
	spoiler = true 
	eksekusi_hasil()

func berhasil_ditekan():
	if not player_in_radius: return

	if lifetime_timer:
		lifetime_timer.stop()
	
	spoiler = false 
	eksekusi_hasil()

func eksekusi_hasil():
	if player_ref:
		if spoiler:
			player_ref.speed = 0
			GameManager.panggil_layar_kalah()
			
			if get_parent().has_node("Timer"):
				get_parent().get_node("Timer").stop()
		else: 
			player_ref.speed = 150
			
	queue_free() 

func _on_area_2d_body_entered(body):
	if body.name == "Player" or body.is_in_group("player"):
		player_in_radius = true
		player_ref = body
		
		player_ref.speed = 50
		if has_node("Label"): $Label.visible = true
		tombol_klik.visible = true
		bar_waktu.visible = true
		
		if lifetime_timer.is_stopped():
			lifetime_timer.start()

func _on_area_2d_body_exited(body):
	if body == player_ref:
		player_in_radius = false
