extends KinematicBody2D

export var speed = 260

var velocity = Vector2()
var is_outside = false

func _init():
	velocity = Vector2(speed, 0).rotated(PI)

func _physics_process(delta):
	if Input.is_action_pressed("ui_select") and is_outside:
		reset()
		
	var collision = move_and_collide(velocity * delta)
	if collision:
		var c = collision.collider.to_local(collision.position)
#		Or use:
#		get_transform().xform_inv(collision.position)
#		See - https://github.com/godotengine/godot-docs/issues/292
		
		velocity = velocity.bounce(collision.normal)
#		Apply rotation only to paddle.
		if collision.collider.is_in_group("Player"):
			# Up: -1, Down: 1
			# Basically, c == 0 - -1, c == 1 - 1
			velocity = velocity.rotated(c.y / 30 - 1)

func reset():
	var screen_size = get_viewport_rect().size
	position = screen_size / 2
	randomize()
	velocity = Vector2(speed, 0).rotated(-PI if randi() > 0.5 else PI)
	is_outside = false

func _on_VisibilityNotifier2D_viewport_exited(viewport):
	is_outside = true
