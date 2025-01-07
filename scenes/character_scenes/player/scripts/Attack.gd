extends Node
class_name Attack

#Signals
signal AttackTransition

#References
@export_category("Player")
@export var player: CharacterBody2D

@export_category("Sprites")
@export var player_sprite: Sprite2D
@export var attack_sprite: Sprite2D
@export var attack_visual: Node2D

@export_category("Player Stats")
@export var player_stats: Node

@export_category("Animation")
@export var attack_animation_tree: AnimationTree

@export_category("Raycasts")
@export var raycast_up_right: RayCast2D
@export var raycast_up_left: RayCast2D
@export var raycast_down_right: RayCast2D
@export var raycast_down_left: RayCast2D


#Common properties and methods
var cooldown_time: float = 1.0
var can_attack: bool = true

var damage: int

#Functions
func _process(delta):
	Update(delta)

func Enter():
	pass

func Exit():
	pass

func Update(_delta: float):
	attack_visual.look_at(player.global_cursor_pos)
	
	if player.global_cursor_pos.x >= 0:
		attack_sprite.flip_v = false
		
	if player.global_cursor_pos.x < 0:
		attack_sprite.flip_v = true
	
func Physics_Update(_delta: float):
	pass

func PerformAttack():
	#This will be overridden by derived classes
	pass

func HandleCooldown():
	#Common cooldown logic
	pass
