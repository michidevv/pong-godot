extends KinematicBody2D

export var speed = 260

var velocity = Vector2()
var is_outside = false

onready var hitSound = $HitSound
onready var scoreSound = $ScoreSound

func _init():
	randomize()
	set_velocity()

func _physics_process(delta):
	if Input.is_action_pressed("ui_select") and is_outside:
		reset()
		
	var collision = move_and_collide(velocity * delta)
	if collision:
		hitSound.play()
		var c = collision.collider.to_local(collision.position)
#		Or use:
#		get_transform().xform_inv(collision.position)
#		See - https://github.com/godotengine/godot-docs/issues/292
		
		velocity = velocity.bounce(collision.normal)
#		Apply rotation only to paddle.
		if collision.collider.is_in_group("Player"):
			# Up: -1, Down: 1
			# Basically, c == 0 - -1, c == 1 - 1
			var e = collision.collider.get_size()
			velocity = velocity.rotated(c.y / e.y - 1)

func reset():
	var screen_size = get_viewport_rect().size
	position = screen_size / 2
	is_outside = false
	
func set_velocity():
	velocity = Vector2(speed, 0).rotated(-PI if rand_range(0, 1) > 0.5 else PI)

func _on_VisibilityNotifier2D_viewport_exited(viewport):
	scoreSound.play()
	is_outside = true
