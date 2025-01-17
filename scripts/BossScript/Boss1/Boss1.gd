extends Entity

func _ready():
	$B1AnimationPlayer.play("idle")
	
func _physics_process(delta):
	#if not is_on_floor():
	#	velocity += get_gravity() * delta
		
	if velocity.x >= 0:
		$sprites.scale.x = -1
	elif velocity.x <0:
		$sprites.scale.x = 1
	move_and_slide()
