extends BossState



@export var BossRef:Entity
var PlayerRef:Player
var Speed = 0.5

func enter():
	PlayerRef = get_tree().get_first_node_in_group("PlayerGroup")
	
func FollowPlayer():
	var direction = PlayerRef.global_position - BossRef.global_position
	
	if direction.length() > 80:
		BossRef.velocity = direction * Speed
	else: 
		pass


func update(_delta: float):
	FollowPlayer()
