extends StaticBody2D

var player_ref: Node2D = null
var player_in_radius = false
var spoiler_gagal = false 
var klik_count: int = 0
var target_klik: int = 2

@onready var lifetime_timer = $LifetimeTimer
@onready var tombol_klik = $Button
@onready var bar_waktu = $SpoilerBar
@onready var bubble1 = $BubblechatRight
@onready var bubble2 = $BubblechatLeft

func _ready():	
	visible = true 
	tombol_klik.visible = false
	bar_waktu.visible = false
	bubble1.visible = true
	bubble2.visible = true
	
	if not lifetime_timer.timeout.is_connected(_on_lifetime_timeout):
		lifetime_timer.timeout.connect(_on_lifetime_timeout)
	if tombol_klik and not tombol_klik.pressed.is_connected(berhasil_ditekan):
		tombol_klik.pressed.connect(berhasil_ditekan)

func _process(_delta):
	if bar_waktu.visible and not lifetime_timer.is_stopped():
		var sisa_persen = (lifetime_timer.time_left / lifetime_timer.wait_time) * 100
		bar_waktu.value = sisa_persen
		
	if bar_waktu.value < 35:
		bar_waktu.tint_progress = Color.RED
	else:
		bar_waktu.tint_progress = Color.GREEN

func _on_lifetime_timeout():
	spoiler_gagal = true 
	eksekusi_hasil()

func berhasil_ditekan():
	if not player_in_radius: return
	
	klik_count += 1
	
	# Memberi feedback visual sederhana saat ditekan (opsional)
	tombol_klik.modulate = Color.DARK_CYAN
	
	if klik_count >= target_klik:
		spoiler_gagal = false 
		lifetime_timer.stop()
		eksekusi_hasil()
	else:
		# Jika belum 2x, kamu bisa tambahkan sedikit animasi 
		# atau suara di sini agar player tahu kliknya terdaftar
		print("Klik ke-", klik_count)

func eksekusi_hasil():
	if player_ref:
		if spoiler_gagal:
			player_ref.speed = 0
			GameManager.panggil_layar_kalah()
		else:
			player_ref.speed = 150 
			bubble1.visible = false
			bubble2.visible = false
			tombol_klik.visible = false
			bar_waktu.visible = false

func _on_area_2d_body_entered(body):
	if body.name == "Player" or body.is_in_group("player"):
		player_in_radius = true
		player_ref = body
		player_ref.speed = 50 
		tombol_klik.visible = true
		bar_waktu.visible = true
		if lifetime_timer.is_stopped():
			lifetime_timer.start()

func _on_area_2d_body_exited(body):
	if body == player_ref:
		player_in_radius = false
