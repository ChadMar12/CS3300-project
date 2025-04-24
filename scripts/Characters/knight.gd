extends Node3D

@onready var move_state_machine = $Knight/AnimationTree.get('parameters/MoveStateMachine/playback')
@onready var attack_state_machine = $Knight/AnimationTree.get('parameters/AttackStateMachine/playback')
@onready var extra_animation = $Knight/AnimationTree.get_tree_root().get_node('ExtraAnimation')	

var special_attack_dic : Dictionary = {
	0: '1H_Melee_Attack_Stab',
	1: '2H_Melee_Attack_Spin',
	2: '1H_Melee_Attack_Slice_Diagonal'
}

var attacking = false
var squash_and_stretch = 1.0:
	set(value):
		squash_and_stretch = value
		var negative = 1.0 + (1.0 - squash_and_stretch)
		scale = Vector3(negative,squash_and_stretch,negative)

func set_move_state(state_name : String) -> void:
	move_state_machine.travel(state_name)

func attack() -> void:
	if not attacking:
		attack_state_machine.travel('1H_Melee_Attack_Slice_Horizontal' if $Knight/SecondAttackTimer.time_left else '1H_Melee_Attack_Chop')
		$Knight/AnimationTree.set('parameters/AttackOneShot/request',  AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)

func attack_toggle(value: bool) -> void:
	attacking = value

## Need to reimplement the blocking animation int he future
#func defend(forward : bool) -> void:
	#var tween = create_tween()
	#tween.tween_method(_defend_change, 1.0 - float(forward), float(forward), 0.25)
	#
#func _defend_change(value : float) -> void:
	#$Knight/AnimationTree.set('parameters/ShieldBlend/blend_amount', value)

func can_damage(value : bool) -> void:
	$"Knight/Rig/Skeleton3D/1H_Sword/1H_Sword".can_damage = value

func hit() -> void:
	$Knight/AnimationTree.set('parameters/ExtraOneShot/request',  AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
	attacking = false

func specialAttack(value : int) -> void:
	extra_animation.animation = special_attack_dic[value]
	$Knight/AnimationTree.set('parameters/ExtraOneShot/request',  AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
