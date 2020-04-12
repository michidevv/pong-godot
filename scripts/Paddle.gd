extends KinematicBody2D

export var speed = 130
export(int, "Player 1", "Player 2") var player = 0

var velocity = Vector2()

func get_input():
#	Add support for AI player type.
	var prefix = "player" + str(player + 1)
	if Input.is_action_pressed(prefix + "_down"):
		velocity.y += 1
	if Input.is_action_pressed(prefix + "_up"):
		velocity.y -= 1

func _physics_process(delta):
	velocity = Vector2()
	get_input()
	move_and_collide(velocity * speed * delta)
