class_name GameManager extends Node

@export var playerScene : PackedScene

# References to child nodes set during initialization
var inputManager : InputManager

var spawnPoints : Array[Vector2]

func _ready() -> void:
	
	# Store references to child nodes
	inputManager = $InputManager
	
	setup_spawn_points()
	
	# Get the currently connected devices
	# NOTE: Setting up the game this was may trigger an end game condition since at this point, only the keyboard is connected
	var connectedDeviceIDs : Array[int] = inputManager.get_connected_device_IDs()
	for i in range(connectedDeviceIDs.size()):
		spawn_player()
	
func _on_input_manager_new_device_connected(inputDevice: InputDevice) -> void:
	spawn_player()
	
func setup_spawn_points() -> void:
	
	var screenSize = get_viewport().size
	
	var xOffset : float = screenSize.x / 5
	var yOffset : float = screenSize.y / 5
	
	spawnPoints.resize(4)
	spawnPoints[3] = Vector2(xOffset, yOffset) # Top left
	spawnPoints[2] = Vector2(screenSize.x - xOffset, yOffset) # Top right
	spawnPoints[1] = Vector2(xOffset, screenSize.y - yOffset) # Bottom left
	spawnPoints[0] = Vector2(screenSize.x - xOffset, screenSize.y - yOffset) # Bottom right
	
func spawn_player() -> void:
	
	# All spawn points have been used
	if spawnPoints.size() == 0:
		return
	
	# Create the player
	var player : Player = playerScene.instantiate()
	add_child(player)
	
	# Position them at a spawn point
	player.global_position = spawnPoints.pop_back()
