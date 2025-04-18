extends Node3D

func _process(delta: float) -> void:
	var collider = $RayCast3D.get_collider()
	print(collider)
	
