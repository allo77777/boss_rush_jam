extends CharacterBody2D
class_name Player

#Debug tools
@export_category("Debug")
@export var debug_mode: bool

#Character movement
@export_category("Character Movement")
@export var SPEED: int = 225
@export var JUMP_HEIGHT: int = -350
@export var ROLL_SPEED_MULTIPLIER: float = 1.5
@export var WALLSLIDE_SPEED: float = 100
@export var CROUCH_SPEED_MULTIPLIER: float = 0.5
@export var PUSHPULL_SPEED_MULTIPLIER: float = 0.5
@export var CLIMB_SPEED: float = 150

#References
@onready var coyote_time: Timer = $Timers/CoyoteTime
@onready var jump_cooldown = $Timers/JumpCooldown
@onready var player_sprite: Sprite2D = $PlayerSprite
@onready var attack_sprite: Sprite2D = $AttackVisuals/AttackSprite
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var player_stats: Node = $PlayerStats
@onready var raycast_cursor: RayCast2D = $Raycasts/RaycastCursor
@onready var element_control: Control = $HUD/ElementControl
@onready var health_bar: ProgressBar = $HUD/HealthBar
@onready var interact_label: Label = $Interactions/Area2D/InteractLabel

#Variables
var facing: int = 1
var can_jump: bool = true
var is_rolling: bool = false
var is_pushpull: bool = false
var is_climbing: bool = false
var prevVelocity: Vector2 = Vector2.ZERO
var cursor_pos: Vector2
var global_cursor_pos: Vector2
var prevhealth: float
var element_index: int = 0
var health: int = 100
var all_interactions = []
var interactable_pos: Vector2
var crate_size: Vector2

#Plays once
func _ready():		
	#Set animation tree to active
	animation_tree.set_active(true)

	#Connect signals
	#element_control.Index.connect(current_index)
	
	#health_bar.Health.connect(current_health)
	
func _process(_delta: float):				
	#Cursor raycast
	raycast_cursor.look_at(global_cursor_pos)
		
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
	
func current_index(index):
	#Update element UI
	element_index = index
		
func current_health(player_health):
	#Update health UI
	health = player_health

func _on_area_2d_area_entered(area: Area2D) -> void:
	#Adds interaction area on entry
	all_interactions.insert(0, area)
	update_interactions()

func _on_area_2d_area_exited(area: Area2D) -> void:
	#Removes interaction area on exit
	all_interactions.erase(area)
	update_interactions()
	
	is_pushpull = false
	is_climbing = false

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
			#Talk
			0: 
				pass
			#Take
			1:
				pass
			#PushPull	
			2: 
				is_pushpull = !is_pushpull
			#Climb
			3:
				is_climbing = !is_climbing
