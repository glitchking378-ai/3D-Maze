extends CharacterBody3D

@export var move_speed: float = 4.5
@export var turn_speed: float = 2.0
@export var gravity: float = 18.0

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _physics_process(delta: float) -> void:
	var move_input := 0.0
	var turn_input := 0.0

	if Input.is_action_pressed("ui_up"):
		move_input += 1.0
	if Input.is_action_pressed("ui_down"):
		move_input -= 1.0
	if Input.is_action_pressed("ui_left"):
		turn_input += 1.0
	if Input.is_action_pressed("ui_right"):
		turn_input -= 1.0

	rotation.y += turn_input * turn_speed * delta

	var forward := -global_transform.basis.z
	var horizontal_velocity := forward * move_input * move_speed
	velocity.x = horizontal_velocity.x
	velocity.z = horizontal_velocity.z

	if not is_on_floor():
		velocity.y -= gravity * delta
	else:
		velocity.y = 0.0

	move_and_slide()
