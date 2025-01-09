extends Node2D

@export_subgroup("Debug")
@export var state_transitions: bool
@export var visible_collisions: bool

func _ready() -> void:	
	if visible_collisions:
		get_tree().debug_collisions_hint = true
