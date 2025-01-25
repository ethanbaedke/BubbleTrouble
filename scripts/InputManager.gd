class_name InputManager extends Node2D

signal new_device_connected(inputDevice : InputDevice)

var deviceList : Array[InputDevice]

func _ready() -> void:
	
	# The keyboard is always active as device 0, even when not being used
	deviceList.append(InputDevice.new())
	
	# Listen for new devices connecting
	Input.joy_connection_changed.connect(_on_joy_connection_changed)

func _input(event: InputEvent) -> void:
	
	# Get any input movement direction
	var moveDir = Input.get_vector("move_left", "move_right", "move_up", "move_down")

	# Get any input aim direction
	var aimDir = Input.get_vector("aim_left", "aim_right", "aim_up", "aim_down")
	
	# If the input was not movement or aim input, ignore it
	if moveDir == Vector2.ZERO and aimDir == Vector2.ZERO:
		return
	
	# First, we assume the input came from the keyboard
	var deviceID : int = 0
	
	# If it did not, set the deviceID to the ID of the controller that gave the input
	if event is not InputEventKey:
		deviceID = event.device + 1
		
	handle_device_input(deviceID, moveDir, aimDir)

func _on_joy_connection_changed(device : int, connected : bool):
	
	# Device IDs are offset by one as to not interfere with the keyboard
	device += 1
	
	# A device was connected
	if connected:
		
		# Allocate space for the new device if necessary
		if device >= deviceList.size():
			deviceList.resize(device + 1)
			new_device_connected.emit(deviceList[device])
		
		# Add the new device to the list
		deviceList[device] = InputDevice.new()
	
	# A device was disconnected
	else:
		
		# Remove the device from the list
		deviceList[device] = null

func handle_device_input(deviceID : int, moveDir : Vector2, aimDir : Vector2) -> void:
	
	# Set the movement and aiming inputs on the relevant device
	deviceList[deviceID].moveInput = moveDir
	deviceList[deviceID].aimInput = aimDir

func get_connected_device_IDs() -> Array[int]:
	
	var connectedDeviceIDs : Array[int]
	
	# Iterate over devices in our device list
	for i in range(deviceList.size()):
		
		# If the device exists, add its ID as a connected device ID
		if deviceList[i] != null:
			connectedDeviceIDs.append(i)

	return connectedDeviceIDs

func get_device_move_input(deviceID : int) -> Vector2:
	
	if deviceList[deviceID] != null:
		return deviceList[deviceID].moveInput
		
	else:
		return Vector2.ZERO
		
func get_device_aim_input(deviceID : int) -> Vector2:
	
	if deviceList[deviceID] != null:
		return deviceList[deviceID].aimInput
		
	else:
		return Vector2.ZERO
