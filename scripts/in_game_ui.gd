extends Control

@onready var health = $Health_Bar

func setup(value: int) -> void:
	health.value = value

func update_health(value: int) -> void:
	
	# This code should check to see if the health of the player is greather than zero and apply damage to it
	# if the value is greather than zero then we will set the value equal to zero and play the death animation.
	
	if health.value != 0:
		health.value = health.value - value
	else:
		health.value = 0
