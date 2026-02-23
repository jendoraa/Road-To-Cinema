extends CharacterBody2D

@onready var anim = $Icon
@export var speed = 150.0

func _physics_process(delta):
	if GameManager.is_game_over:
		velocity = Vector2.ZERO
		anim.play("idle")
		return
	velocity.x = speed
	move_and_slide()
