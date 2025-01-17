extends CharacterBody2D
class_name Entity

@export var PlayerRef:Player
var health:float = 100
var damage:float = 10
 

func take_dmg():
	health -= damage

func die():
	if health<= 0:
		print("dead")
