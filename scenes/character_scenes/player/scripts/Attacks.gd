extends Node
class_name Attacks

@export var player: CharacterBody2D
@export var player_stats: Node

#---Variables---
var element

func _physics_process(delta: float) -> void:
	
	element = player_stats.element[player_stats.element_index]
	
	if Input.is_action_just_pressed("primary_attack"):
		if player.debug_mode == true:
			print("Melee Attack: " + element)
			
		match element:
			
			"fire":
				pass
			
			"earth":
				pass
				
			"water":
				pass
			
			"air":
				pass
		
	if Input.is_action_just_pressed("secondary_attack"):
		if player.debug_mode == true:
			print("Secondairy Attack: " + element)
		
		match element:
			
			"fire":
				pass
			
			"earth":
				pass
				
			"water":
				pass
			
			"air":
				pass
		
		
	if Input.is_action_just_pressed("tertiary_attack"):
		if player.debug_mode == true:
			print("Tertiary Attack: " + element)
			
		match element:
			
			"fire":
				pass
			
			"earth":
				pass
				
			"water":
				pass
			
			"air":
				pass
