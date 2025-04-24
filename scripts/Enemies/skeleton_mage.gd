extends Enemy

signal cast_spell(type: String, pos: Vector3, direction: Vector2, size: float)

func _ready() -> void:
	attack_radius = 10.0
	
func _physics_process(delta: float) -> void:
	move_to_player(delta)
	
func _on_attack_timer_timeout() -> void:
	$Node/AttackTimer.wait_time = rng.randf_range(2.0, 3.0)
	if position.distance_to(player.position) < attack_radius:
		$AnimationTree.set("parameters/OneShot/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)

func shoot_fireball() -> void:
	cast_spell.emit('fireball', $skin/Rig/Skeleton3D/BoneAttachment3D/Skeleton_Staff2/Marker3D.global_position, Vector2.RIGHT, 1.0)
	
