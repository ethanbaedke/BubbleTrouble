class_name InputManager extends Node2D

func _process(delta: float) -> void:
	
	# Get any input movement direction
	var moveDir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	print(moveDir)
	
	# Get any input aim direction
	var aimDir = Input.get_vector("aim_left", "aim_right", "aim_up", "aim_down")
	print(aimDir)
