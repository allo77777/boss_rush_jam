extends BossState

@export var AnimPlayer: AnimationPlayer
@export var PlayerRef:Player
@export var BossRef:Entity

func enter():
	AnimPlayer.play("idle")
	
func ToMoveState():
	if PlayerRef: 
		print("far")
	else:
		print("close")
func update(_delta: float):
	ToMoveState()
