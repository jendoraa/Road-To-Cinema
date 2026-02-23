extends Camera2D

@onready var player = $".."

func _process(_delta):
	global_position.x = player.global_position.x
