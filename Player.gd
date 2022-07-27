extends KinematicBody2D

export(int) var GRAVITY = 4 
export(int) var ACCELARATE_FALLING_GRAVITY = 1
export(int) var JUMP_FORCE = -150
export(int) var FALLING_FORCE = -60
export(int) var SPEED = 150


var velocity = Vector2.ZERO

func _physics_process(delta):
	apply_gravity()	
	var input = Vector2.ZERO
	input.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	
	if input.x == 0:
		if is_on_floor():
			apply_friction()
	else:
		move_player(input.x)
	
	if is_on_floor():
		jump()
	else:
		falling()
	
	velocity = move_and_slide(velocity, Vector2.UP)

func apply_gravity():
	velocity.y += GRAVITY
	velocity.y = min(velocity.y, 200)
	
func apply_friction():
	velocity.x = move_toward(velocity.x, 0, 20)

func falling():
	if Input.is_action_just_released("ui_up") and velocity.y < FALLING_FORCE:
		velocity.y = FALLING_FORCE
	
	# Accelarate fall
	if velocity.y > 0:
		velocity.y += ACCELARATE_FALLING_GRAVITY

func jump():
	if Input.is_action_just_pressed("ui_up"):
		velocity.y = JUMP_FORCE

func move_player(direction):
	velocity.x = move_toward(velocity.x, SPEED * direction, 20)
