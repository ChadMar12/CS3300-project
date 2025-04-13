extends Level

func _on_door_to_world_body_entered(body: Node3D) -> void:
	switchLevel('MainWorld')
