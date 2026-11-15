extends Camera3D
class_name GameCamera

# Camera follow script for bus game

@export var target: Node3D
@export var follow_distance: float = 8.0
@export var follow_height: float = 3.0
@export var follow_smoothness: float = 0.1
@export var rotation_smoothness: float = 0.1

# Camera offset
@export var offset: Vector3 = Vector3(0, 2, -5)

# State
var current_position: Vector3 = Vector3.ZERO
var target_position: Vector3 = Vector3.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if target == null:
		# Try to find bus automatically
		var bus = get_tree().get_first_node_in_group("bus")
		if bus:
			target = bus
			print("Camera found bus target automatically")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if target:
		update_camera_position(delta)

func update_camera_position(delta: float) -> void:
	if target == null:
		return
	
	# Calculate target position
	target_position = target.global_position + offset
	
	# Smooth follow
	current_position = current_position.lerp(target_position, follow_smoothness)
	
	# Apply position
	global_position = current_position
	
	# Look at target
	look_at(target.global_position + Vector3(0, 1, 0), Vector3.UP)

func set_target(new_target: Node3D) -> void:
	target = new_target
