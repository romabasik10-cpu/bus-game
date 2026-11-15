extends CharacterBody3D
class_name Passenger

# Passenger AI script

# Movement
@export var walk_speed: float = 2.0
@export var wait_time: float = 5.0

# State
enum State { WAITING, WALKING_TO_BUS, IN_BUS, WALKING_AWAY }
var current_state: State = State.WAITING

# Target
var target_position: Vector3 = Vector3.ZERO
var bus: CharacterBody3D

# Timer
var wait_timer: float = 0.0

# Animation
@onready var animation_player: AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Find bus
	bus = get_tree().get_first_node_in_group("bus")
	
	# Set random wait time
	wait_timer = randf() * wait_time
	
	# Set initial target (bus stop)
	target_position = global_position + Vector3(randf_range(-2, 2), randf_range(-2, 2), 0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	match current_state:
		State.WAITING:
			wait_at_stop(delta)
			look_for_bus()
		State.WALKING_TO_BUS:
			walk_to_bus(delta)
		State.IN_BUS:
			# Do nothing, passenger is in bus
			pass
		State.WALKING_AWAY:
			walk_away(delta)

func wait_at_stop(delta: float) -> void:
	wait_timer -= delta
	if wait_timer <= 0:
		# Start walking towards bus stop position
		current_state = State.WALKING_TO_BUS
		wait_timer = 0.0

func look_for_bus() -> void:
	if bus == null:
		bus = get_tree().get_first_node_in_group("bus")
		return
	
	# Check if bus is near
	var distance_to_bus: float = global_position.distance_to(bus.global_position)
	if distance_to_bus < 3.0:
		# Try to enter bus
		if bus.get_passenger_count() < bus.get_max_passengers():
			if bus.pick_up_passenger():
				current_state = State.IN_BUS
				visible = false  # Hide passenger when in bus

func walk_to_bus(delta: float) -> void:
	if bus == null:
		bus = get_tree().get_first_node_in_group("bus")
		if bus == null:
			return
	
	# Move towards bus
	var direction: Vector3 = (bus.global_position - global_position).normalized()
	velocity = direction * walk_speed
	move_and_slide()
	
	# Check if reached bus
	var distance: float = global_position.distance_to(bus.global_position)
	if distance < 1.0:
		# Try to enter bus
		if bus.get_passenger_count() < bus.get_max_passengers():
			if bus.pick_up_passenger():
				current_state = State.IN_BUS
				visible = false

func walk_away(delta: float) -> void:
	# Walk away from bus stop
	var direction: Vector3 = (target_position - global_position).normalized()
	velocity = direction * walk_speed
	move_and_slide()
	
	# Check if reached destination
	var distance: float = global_position.distance_to(target_position)
	if distance < 0.5:
		queue_free()  # Remove passenger after reaching destination

func exit_bus(bus_stop_position: Vector3) -> void:
	current_state = State.WALKING_AWAY
	visible = true
	global_position = bus_stop_position + Vector3(randf_range(-1, 1), randf_range(-1, 1), 0)
	target_position = global_position + Vector3(randf_range(-5, 5), randf_range(-5, 5), 0)
