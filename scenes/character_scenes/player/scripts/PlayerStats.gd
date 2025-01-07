extends Node
class_name PlayerStats

@export var player: CharacterBody2D

#---Stats----

#
var health: int

#Movement
var double_jump_amount = 1
var double_jump_used = double_jump_amount

#---Abilities---
var ability_points: int

var element = ["fire", "earth", "water", "air"]
var element_index: int

var double_jump = true

#Update stats
func _process(_delta: float) -> void:
	element_index = player.element_index
	
	health = player.health
