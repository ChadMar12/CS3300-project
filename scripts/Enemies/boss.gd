extends Enemy

const simple_attacks = {
	'slice': "2H_Melee_Attack_Slice",
	'spin': "2H_Melee_Attack_Spin",
	'range': "2H_Melee_Attack_Stab",
}

@export var spin_speed = 15
var spinning := false
var can_damage_toggle := false

func _process(_delta: float) -> void:
	attack_logic()

func _physics_process(delta: float) -> void:
	move_to_player(delta)
	

func _on_attack_timer_timeout() -> void:
	if position.distance_to(player.position) < 3.0:
		melee_attack_animation()
	else:
		if rng.randi() % 2:
			range_attack_animation()
		else:
			spin_attack_animation()
		
func spin_attack_animation() -> void:
	var tween = create_tween()
	tween.tween_property(self, 'speed', spin_speed, 0.5)
	tween.tween_method(_spin_transition, 0.0, 1.0, 0.3)
	$Node/AttackTimer.stop()
	spinning = true
	can_damage_toggle = true
		
func _spin_transition(value: float) -> void:
	$AnimationTree.set("parameters/SpinBlend/blend_amount", value)
		
func range_attack_animation() -> void:
	stop_movement(1.5, 1.5)
	attack_animation.animation = simple_attacks['range']
	$AnimationTree.set("parameters/AttackOneShot/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
	
func melee_attack_animation():
	attack_animation.animation = simple_attacks['slice' if rng.randi() % 2 else 'spin']
	$AnimationTree.set("parameters/AttackOneShot/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)

func _on_area_3d_body_entered(_body: Node3D) -> void:
	if spinning:
		var tween = create_tween()
		tween.tween_property(self, 'speed', walk_speed, 0.5)
		tween.tween_method(_spin_transition, 1.0, 0.0, 0.3)
		spinning = false
		can_damage_toggle = false
		$Node/AttackTimer.start()

func can_damage(value: bool) -> void:
	can_damage_toggle = value

func attack_logic() -> void:
	if can_damage_toggle:
		var collider = $skin/Rig/Skeleton3D/BoneAttachment3D/Skeleton_Mace2/RayCast3D.get_collider()
		if collider and 'hit' in collider:
			collider.hit()

func shoot_fireball() -> void:
	var direction = (player.position - position).normalized()
	var dir_2d = Vector2(direction.x, direction.z)
	var pos = $skin/Rig/Skeleton3D/BoneAttachment3D/Skeleton_Mace2/Marker3D.global_position
	cast_spell.emit('fireball', pos, dir_2d, 1.0)
