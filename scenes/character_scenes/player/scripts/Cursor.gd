extends Node

# Load the custom images for the mouse cursor.
var cursor = load("res://scenes/character_scenes/player/assets/Mouse Cursor.png")

func _ready():
	# Changes only the arrow shape of the cursor.
	# This is similar to changing it in the project settings.
	Input.set_custom_mouse_cursor(cursor)

	# Changes a specific shape of the cursor (here, the I-beam shape).
	Input.set_custom_mouse_cursor(cursor, Input.CURSOR_IBEAM)
