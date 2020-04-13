extends KinematicBody2D

signal scored_point

export var speed = 260

var velocity = Vector2()
var is_running = false

onready var hit_sound = $HitSound
onready var score_sound = $ScoreSound

func _init():
	randomize()

func _physics_process(delta):
	if Input.is_action_pressed("ui_select") and not is_running:
		is_running = true
		set_velocity()
		
	var collision = move_and_collide(velocity * delta)
	if collision:
		hit_sound.play()
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
	velocity = Vector2()
	var screen_size = get_viewport_rect().size
	position = screen_size / 2
	
func set_velocity():
	velocity = Vector2(speed, 0).rotated(0 if rand_range(0, 1) > 0.5 else PI)

func _on_VisibilityNotifier2D_viewport_exited(viewport):
	score_sound.play()
	is_running = false
	emit_signal("scored_point", "1" if position.x > 0 else "2")
	reset()
