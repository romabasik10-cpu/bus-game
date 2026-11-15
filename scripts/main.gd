extends Node3D

# Main game script
# Controls the game flow, spawning, and game state

@export var bus_scene: PackedScene
@export var world_scene: PackedScene
@export var ui_scene: PackedScene

# Game state
var game_started: bool = false
var score: int = 0
var time_left: float = 300.0  # 5 minutes
var current_level: int = 1

# References
var bus: CharacterBody3D
var ui: CanvasLayer
var camera: Camera3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Set up references
	bus = $Bus
	ui = $UI
	camera = $Camera
	
	# Initialize game
	start_game()
	
	# Connect signals
	if bus:
		bus.connect("passenger_picked_up", _on_passenger_picked_up)
		bus.connect("passenger_dropped_off", _on_passenger_dropped_off)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if game_started:
		update_game_timer(delta)

func start_game() -> void:
	game_started = true
	score = 0
	time_left = 300.0
	current_level = 1
	print("Game Started!")

func update_game_timer(delta: float) -> void:
	time_left -= delta
	if time_left <= 0:
		game_over()

func _on_passenger_picked_up() -> void:
	score += 10
	print("Passenger picked up! Score: ", score)

func _on_passenger_dropped_off() -> void:
	score += 20
	print("Passenger dropped off! Score: ", score)

func game_over() -> void:
	game_started = false
	print("Game Over! Final Score: ", score)

func add_score(points: int) -> void:
	score += points

func get_score() -> int:
	return score

func get_time_left() -> float:
	return time_left
