extends StaticBody2D

@export var margin_pojok : Vector2 = Vector2(67, 76) 
var player_ref: Node2D = null
var is_active = false 

@onready var anim = $AnimatedSprite2D
@onready var lifetime_timer = $LifetimeTimer
@onready var tombol_klik = $Button
@onready var bar_waktu = $SpoilerBar

func _ready():
	player_ref = get_tree().get_first_node_in_group("player")
	
	posisikan_di_pojok()
	set_mode_idle()
	
	if not lifetime_timer.timeout.is_connected(_on_lifetime_timeout):
		lifetime_timer.timeout.connect(_on_lifetime_timeout)
	if tombol_klik and not tombol_klik.pressed.is_connected(berhasil_ditekan):
		tombol_klik.pressed.connect(berhasil_ditekan)

func _process(_delta):
	posisikan_di_pojok()
	
	if is_active and not lifetime_timer.is_stopped():
		bar_waktu.value = (lifetime_timer.time_left / lifetime_timer.wait_time) * 100
		
	if bar_waktu.value < 35:
		bar_waktu.tint_progress = Color.RED
	else:
		bar_waktu.tint_progress = Color.GREEN
			
func posisikan_di_pojok():
	var screen_size = get_viewport_rect().size
	position = Vector2(screen_size.x - margin_pojok.x, screen_size.y - margin_pojok.y)

func panggil_event_spoiler():
	if not is_inside_tree(): await ready
	
	is_active = true
	tombol_klik.visible = true
	bar_waktu.visible = true
	
	anim.play("on")
	if player_ref: player_ref.speed = 50 
	
	lifetime_timer.start()

func set_mode_idle():
	is_active = false
	tombol_klik.visible = false
	bar_waktu.visible = false
	if anim: anim.play("off")
	if player_ref: player_ref.speed = 150 

func berhasil_ditekan():
	if not is_active: return
	lifetime_timer.stop()
	set_mode_idle()

func _on_lifetime_timeout():
	if not is_active: return
	if player_ref: player_ref.speed = 0
	GameManager.panggil_layar_kalah()
