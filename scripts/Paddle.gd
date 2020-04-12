extends KinematicBody2D

export var speed = 120
export(int, "Player 1", "Player 2") var player = 0

var velocity = Vector2()

#onready var polygon = $Polygon2D 

func get_input():
	var prefix = "player%s"
	if Input.is_action_pressed(prefix % (player + 1) + "_down"):
		velocity.y += 1
	if Input.is_action_pressed(prefix % (player + 1) + "_up"):
		velocity.y -= 1

func _physics_process(delta):
	velocity = Vector2()
	get_input()
	move_and_collide(velocity * speed * delta)
