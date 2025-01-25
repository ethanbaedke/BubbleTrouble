class_name GameManager extends Node2D

# References to child nodes set during initialization
var inputManager : InputManager

func _ready() -> void:
	
	# Store references to child nodes
	inputManager = $InputManager
	
	# Get the currently connected devices
	# NOTE: Setting up the game this was may trigger an end game condition since at this point, only the keyboard is connected
	var connectedDeviceIDs : Array[int] = inputManager.get_connected_device_IDs()
	for i in range(connectedDeviceIDs.size()):
		spawn_player()
	
func _on_input_manager_new_device_connected(inputDevice: InputDevice) -> void:
	spawn_player()
	
func spawn_player() -> void:
	print("Player Spawned!")
