extends RayCast2D

@export var player: CharacterBody2D

func _process(delta: float) -> void:
	self.look_at(player.cursor_pos)
	
	draw

func draw():
	# Draw a line from the origin to the cast point
	draw_line(Vector2.ZERO, player.cursor_pos, Color.RED, 2)
