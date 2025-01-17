extends Entity

func _ready():
	pass
	
func _physics_process(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	if velocity.length() == 0:
		$B1AnimationPlayer.play("idle")
	else:
		pass
	move_and_slide()
