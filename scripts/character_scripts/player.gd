extends CharacterBody2D
class_name Player

#Character movement
@export_category("Character Movement")
@export var SPEED: int = 225
@export var JUMP_HEIGHT: int = -350
@export var DASH_SPEED_MULTIPLIER: float = 1.75
@export var WALLSLIDE_SPEED: float = 100
@export var WALLSLIDE_JUMP: float = 225
@export var CROUCH_SPEED_MULTIPLIER: float = 0.5

@export_category("Abilities")
@export_subgroup("Double Jump")
@export var DOUBLE_JUMP: bool  = true
@export var DOUBLE_JUMP_AMOUNT: int = 1
@export var DOUBLE_JUMP_USED: int
@export var IS_DOUBLE_JUMPING: bool = false
@export_subgroup("Dash")
@export var DASH: bool = true
@export var DASH_AMOUNT: int = 1
@export var DASH_USED: int 
@export var IS_DASHING: bool = false
@export_subgroup("Attack")


#References
@onready var root: Node2D = $".."
@onready var coyote_time: Timer = $timers/coyote_time
@onready var jump_cooldown: Timer = $timers/jump_cooldown
@onready var player_sprite: Sprite2D = $player_sprite
@onready var animation_tree: AnimationTree = $animation_tree
@onready var interact_label: Label = $interactions/interaction_area/interact_label

#Variables
var debug_mode: bool = false
var facing: int = 1
var prevVelocity: Vector2 = Vector2.ZERO
var cursor_pos: Vector2
var global_cursor_pos: Vector2
var all_interactions = []
var interactable_pos: Vector2

var idle_blend_tree

#Plays once
func _ready():	
	#Debug
	debug_mode = root.state_transitions
	DOUBLE_JUMP_USED = DOUBLE_JUMP_AMOUNT
	DASH_USED = DASH_AMOUNT
		
	#Set animation tree to active
	animation_tree.set_active(true)
	
func _process(_delta: float):				
		
	#Allows early jump press
	if Input.is_action_just_pressed("jump"):
		jump_cooldown.start()
		
	if Input.is_action_just_pressed("interact"):
		#Interaction system
		execute_interaction()
	
func _physics_process(_delta: float):	
	#Get cursor position
	cursor_pos = player_sprite.get_local_mouse_position()
	global_cursor_pos = player_sprite.get_global_mouse_position()
	
	#Allows late jump press
	if is_on_floor():
		coyote_time.start()
		
	#Smoother Jumps
	prevVelocity = velocity
	
	move_and_slide()

func _on_area_2d_area_entered(area: Area2D) -> void:
	#Adds interaction area on entry
	all_interactions.insert(0, area)
	update_interactions()

func _on_area_2d_area_exited(area: Area2D) -> void:
	#Removes interaction area on exit
	all_interactions.erase(area)
	update_interactions()

func update_interactions():
	#Changes the text displayed
	if all_interactions:
		interact_label.text = all_interactions[0].interact_label
	else:
		interact_label.text = ""
		
func execute_interaction():
	#Executes when "E" is pressed
	if all_interactions:
		
		var current_interaction = all_interactions[0]
		
		match current_interaction.interact_type:		
			#...
			0: 
				pass
			#...
			1:
				pass
