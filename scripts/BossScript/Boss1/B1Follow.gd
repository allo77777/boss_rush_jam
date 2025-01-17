extends BossState



@export var BossRef:Entity
var PlayerRef:Player
var Speed = 0.5

func enter():
	PlayerRef = get_tree().get_first_node_in_group("PlayerGroup")
	
func FollowPlayer():
	var DistanceToPlayer:float = PlayerRef.position.x - BossRef.position.x
	if DistanceToPlayer >= 20:
		BossRef.velocity.x  = DistanceToPlayer * Speed
	elif DistanceToPlayer <= 20:
		BossRef.velocity.x  = DistanceToPlayer * Speed
	else:
		pass
func update(_delta: float):
	FollowPlayer()
