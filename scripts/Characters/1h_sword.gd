extends Node3D

var can_damage = false

func _process(delta: float) -> void:
	
	if can_damage:
		var collider = $RayCast3D.get_collider()
		print(collider)
	
