extends CharacterBody3D
class_name Bus

# Bus movement and control script

# Movement settings
@export var max_speed: float = 20.0
@export var acceleration: float = 5.0
@export var deceleration: float = 10.0
@export var brake_force: float = 15.0
@export var rotation_speed: float = 2.0
@export var max_rotation: float = 0.5  # Max rotation angle in radians

# Physics
@export var mass: float = 5000.0

# Passengers
@export var max_passengers: int = 20
var current_passengers: int = 0
var passengers_at_stops: Array = []

# Audio
@onready var horn_player: AudioStreamPlayer3D = $HornPlayer
@onready var engine_player: AudioStreamPlayer3D = $AudioPlayer

# State
var current_speed: float = 0.0
var is_braking: bool = false
var is_honking: bool = false

# Signals
signal passenger_picked_up
signal passenger_dropped_off
signal honked

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	handle_movement(delta)
	handle_rotation(delta)
	update_engine_sound()

func handle_movement(delta: float) -> void:
	var input_dir: Vector2 = Vector2.ZERO
	
	# Get input
	if Input.is_action_pressed("move_forward"):
		input_dir.y += 1.0
	if Input.is_action_pressed("move_back"):
		input_dir.y -= 1.0
	
	# Accelerate or decelerate
	if input_dir.y > 0:
		current_speed = move_toward(current_speed, max_speed, acceleration * delta)
		is_braking = false
	elif input_dir.y < 0:
		current_speed = move_toward(current_speed, -max_speed * 0.5, acceleration * delta * 0.5)
		is_braking = false
	else:
		# Natural deceleration
		current_speed = move_toward(current_speed, 0.0, deceleration * delta)
		is_braking = false
	
	# Brake
	if Input.is_action_pressed("brake") or is_braking:
		current_speed = move_toward(current_speed, 0.0, brake_force * delta)
		is_braking = true
	
	# Apply movement
	if current_speed != 0:
		var forward_dir: Vector3 = -global_transform.basis.z
		velocity = forward_dir * current_speed
		move_and_slide()
	else:
		velocity = Vector3.ZERO
		move_and_slide()

func handle_rotation(delta: float) -> void:
	var steering: float = 0.0
	
	if Input.is_action_pressed("move_left"):
		steering -= 1.0
	if Input.is_action_pressed("move_right"):
		steering += 1.0
	
	# Only rotate when moving
	if current_speed > 1.0 or current_speed < -1.0:
		var turn_factor: float = steering * rotation_speed * delta
		# Limit rotation based on speed
		var speed_factor: float = clamp(abs(current_speed) / max_speed, 0.3, 1.0)
		rotate_y(turn_factor * speed_factor)

func update_engine_sound() -> void:
	if engine_player:
		# Adjust pitch based on speed
		var pitch: float = 0.5 + (abs(current_speed) / max_speed) * 0.5
		engine_player.pitch_scale = pitch
		engine_player.playing = abs(current_speed) > 0.1

func honk() -> void:
	if horn_player:
		horn_player.play()
	signal honked

func pick_up_passenger() -> bool:
	if current_passengers < max_passengers:
		current_passengers += 1
		signal passenger_picked_up
		return true
	return false

func drop_off_passenger() -> bool:
	if current_passengers > 0:
		current_passengers -= 1
		signal passenger_dropped_off
		return true
	return false

func get_passenger_count() -> int:
	return current_passengers

func get_current_speed() -> float:
	return current_speed

func get_max_speed() -> float:
	return max_speed

# Called when the node is about to be removed from the scene tree.
func _exit_tree() -> void:
	pass

# Handle input
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("horn"):
		honk()
