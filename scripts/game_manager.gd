extends Node
class_name GameManager

# Global game manager singleton

# Game settings
@export var max_passengers: int = 20
@export var game_duration: float = 300.0  # 5 minutes
@export var spawn_interval: float = 5.0

# State
var score: int = 0
var time_left: float = 0.0
var game_started: bool = false
var passengers_spawned: int = 0
var passengers_delivered: int = 0

# References
var bus: CharacterBody3D
var ui: CanvasLayer

# Timers
var spawn_timer: float = 0.0

# Signals
signal game_started
signal game_over
signal score_updated(new_score: int)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Find references
	bus = get_tree().get_first_node_in_group("bus")
	ui = get_tree().get_first_node_in_group("ui")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if game_started:
		update_game_timer(delta)
		update_spawn_timer(delta)

func start_game() -> void:
	score = 0
	time_left = game_duration
	passengers_spawned = 0
	passengers_delivered = 0
	game_started = true
	spawn_timer = 0.0
	
	# Update UI
	if ui:
		ui.update_score(score)
		ui.update_time(time_left)
		ui.hide_title_screen()
		ui.hide_game_over_screen()
	
	# Emit signal
	game_started.emit()
	print("Game started!")

func update_game_timer(delta: float) -> void:
	time_left -= delta
	
	# Update UI
	if ui:
		ui.update_time(time_left)
	
	if time_left <= 0:
		game_over()

func update_spawn_timer(delta: float) -> void:
	spawn_timer += delta
	if spawn_timer >= spawn_interval:
		spawn_timer = 0.0
		spawn_passenger()

func spawn_passenger() -> void:
	# Find spawn points
	var spawn_points = get_tree().get_nodes_in_group("passenger_spawn")
	if spawn_points.size() > 0:
		var spawn_point = spawn_points[randi() % spawn_points.size()]
		# Create passenger
		var passenger_scene = preload("res://../models/characters/passenger.glb")
		var passenger = passenger_scene.instantiate()
		passenger.global_position = spawn_point.global_position
		get_tree().root.add_child(passenger)
		passengers_spawned += 1
		print("Passenger spawned at ", spawn_point.global_position)

func add_score(points: int) -> void:
	score += points
	
	# Update UI
	if ui:
		ui.update_score(score)
	
	# Emit signal
	score_updated.emit(score)

func get_score() -> int:
	return score

func get_time_left() -> float:
	return time_left

func game_over() -> void:
	game_started = false
	
	# Show game over screen
	if ui:
		ui.show_game_over_screen(score)
	
	# Emit signal
	game_over.emit()
	print("Game Over! Final Score: ", score)

func increase_passenger_count() -> void:
	passengers_delivered += 1
	if ui and bus:
		ui.update_passengers(bus.get_passenger_count(), bus.get_max_passengers())

# Connect to bus signals
func connect_to_bus(bus_node: CharacterBody3D) -> void:
	bus = bus_node
	bus.connect("passenger_picked_up", _on_passenger_picked_up)
	bus.connect("passenger_dropped_off", _on_passenger_dropped_off)

func _on_passenger_picked_up() -> void:
	add_score(10)
	increase_passenger_count()

func _on_passenger_dropped_off() -> void:
	add_score(20)
	increase_passenger_count()
