class_name InputDevice extends Object

signal move_triggered(direction : Vector2)
signal aim_triggered(direction : Vector2)

func set_move_input(direction : Vector2) -> void:
	
	if direction != Vector2.ZERO:
		move_triggered.emit(direction)
	
func set_aim_input(direction : Vector2) -> void:
	
	if direction != Vector2.ZERO:
		aim_triggered.emit(direction)
