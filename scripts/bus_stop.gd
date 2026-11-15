extends Area3D
class_name BusStop

# Bus stop script

# Visual feedback
@onready var model: Node3D = $Mesh

# State
var has_passengers: bool = false
var passenger_count: int = 0

# Signals
signal passenger_waiting
signal passenger_entered_bus

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect("body_entered", _on_body_entered)
	connect("body_exited", _on_body_exited)

# Called when a body enters the area
func _on_body_entered(body: Node3D) -> void:
	if body is CharacterBody3D:
		if "bus" in body.get_groups():
			# Bus entered stop
			handle_bus_arrival(body)
		elif "passenger" in body.get_groups():
			# Passenger entered stop
			passenger_count += 1
			has_passengers = true
			signal passenger_waiting

# Called when a body exits the area
func _on_body_exited(body: Node3D) -> void:
	if body is CharacterBody3D:
		if "bus" in body.get_groups():
			# Bus left stop
			handle_bus_departure(body)

func handle_bus_arrival(bus: CharacterBody3D) -> void:
	# Flash the bus stop sign
	if model:
		model.modulate = Color(1, 1, 0)  # Yellow
		get_tree().create_timer(0.5).timeout.connect(_reset_stop_color)

func handle_bus_departure(bus: CharacterBody3D) -> void:
	# Reset color
	_reset_stop_color()

func _reset_stop_color() -> void:
	if model:
		model.modulate = Color(1, 1, 1)

func add_passenger() -> void:
	passenger_count += 1
	has_passengers = true

func remove_passenger() -> void:
	passenger_count = max(0, passenger_count - 1)
	if passenger_count == 0:
		has_passengers = false

func get_passenger_count() -> int:
	return passenger_count

func has_passengers_waiting() -> bool:
	return has_passengers
