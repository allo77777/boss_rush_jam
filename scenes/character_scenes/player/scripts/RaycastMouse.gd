extends RayCast2D

@export var player: CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("is colliding")
	
func _process(delta: float) -> void:
	self.look_at(player.cursor_pos)
	
	draw

func _physics_process(delta: float) -> void:
	if is_colliding():
		if get_collider() != CharacterBody2D:
			print("Collision")

func draw():
	# Draw a line from the origin to the cast point
	draw_line(Vector2.ZERO, player.cursor_pos, Color.RED, 2)
