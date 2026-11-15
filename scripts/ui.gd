extends CanvasLayer
class_name GameUI

# UI Controller for the bus game

# References
@onready var score_value: Label = $HUD/ScorePanel/ScoreValue
@onready var time_value: Label = $HUD/TimePanel/TimeValue
@onready var passengers_value: Label = $HUD/PassengersPanel/PassengersValue
@onready var speed_value: Label = $HUD/SpeedPanel/SpeedValue

@onready var title_screen: Panel = $TitleScreen
@onready var game_over_screen: Panel = $GameOverScreen
@onready var final_score_label: Label = $GameOverScreen/FinalScoreLabel

# State
var game_started: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Start with title screen
	show_title_screen()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Update UI elements
func update_score(score: int) -> void:
	if score_value:
		score_value.text = str(score)

func update_time(time_left: float) -> void:
	if time_value:
		var minutes: int = int(time_left) / 60
		var seconds: int = int(time_left) % 60
		time_value.text = "%02d:%02d" % [minutes, seconds]

func update_passengers(current: int, max_passengers: int) -> void:
	if passengers_value:
		passengers_value.text = "%d/%d" % [current, max_passengers]

func update_speed(speed: float) -> void:
	if speed_value:
		# Convert to km/h
		var speed_kmh: float = abs(speed) * 3.6
		speed_value.text = "%d km/h" % int(speed_kmh)

# Screen management
func show_title_screen() -> void:
	title_screen.visible = true
	game_over_screen.visible = false
	game_started = false

func hide_title_screen() -> void:
	title_screen.visible = false

func show_game_over_screen(final_score: int) -> void:
	game_over_screen.visible = true
	final_score_label.text = "SCORE: %d" % final_score
	game_started = false

func hide_game_over_screen() -> void:
	game_over_screen.visible = false

# Button callbacks
func _on_start_button_pressed() -> void:
	hide_title_screen()
	game_started = true
	# Emit signal to start game
	get_parent().start_game()

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_restart_button_pressed() -> void:
	hide_game_over_screen()
	get_parent().start_game()
