extends Node
class_name State

#Signals
signal StateTransition

#References
@export_category("Player")
@export var player: CharacterBody2D

@export_category("Sprites")
@export var player_sprite: Sprite2D

@export_category("Animation")
@export var animation_tree: AnimationTree

@export_category("Raycasts")
@export var raycast_up_right: RayCast2D
@export var raycast_up_left: RayCast2D
@export var raycast_down_right: RayCast2D
@export var raycast_down_left: RayCast2D

@export_category("Timers")
@export var coyote_time: Timer
@export var jump_cooldown: Timer

#Variables
var direction: float
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity", 980)

#Functions
func _process(delta):
	Update(delta)

func Enter():
	pass

func Exit():
	pass

func Update(_delta: float):
	pass
	
func Physics_Update(_delta: float):
	pass
	
func Direction(flipSprite: bool):
	#Get player inputs to determine looking direction and flip sprite
	
	direction = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
		
	if direction == 1:
		if flipSprite == true:
			player.facing = 1
			player_sprite.flip_h = false
		
	elif direction == -1:		
		if flipSprite == true:
			player.facing = -1
			player_sprite.flip_h = true
