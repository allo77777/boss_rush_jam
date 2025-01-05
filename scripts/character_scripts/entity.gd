extends CharacterBody2D
class_name Entity

var health:float = 100.0
var damage:float = 10.0
var speed:float = 700.0
var heal_amount:float = 40.0

func take_dmg():
	health -= damage


#healing isnt a priority for a mechanic
func heal():
	health += heal_amount

#to be put in physics process.
func die():
	if health <=0:
		print("died")
		#could add queue_free() for the bosses and other logic for death animations etc.
