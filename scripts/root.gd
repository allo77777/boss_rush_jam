extends Node2D

@export var debug_mode: bool = false

func _ready() -> void:	
	if debug_mode:
		get_tree().debug_collisions_hint = true
