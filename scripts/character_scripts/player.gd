extends Entity
#since this extends from Entity, the class we created in the entity scene (entity.tscn),
#we have access to its declared variables and functions, we can also overwrite them so that the player doesnt have-
#the same health or damage as a boss.same with the functions.

func _ready():
	#to show what top comments says:  we havent declared health in this script. but we did in the class one
	print(health)


func _physics_process(_delta):
	pass
