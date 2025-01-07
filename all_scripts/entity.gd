extends CharacterBody2D
class_name Entity

var health:float = 100
var damage:float = 10
 

func take_dmg():
	health -= damage

func die():
	if health<= 0:
		print("dead")
