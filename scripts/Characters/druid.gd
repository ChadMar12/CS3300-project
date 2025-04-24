extends Node3D

@onready var move_state_machine = $Druid/AnimationTree.get('parameters/MoveStateMachine/playback')
@onready var extra_animation = $Druid/AnimationTree.get_tree_root().get_node('ExtraAnimation')	

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
	$Druid/AnimationTree.set('parameters/AttackOneShot/request',  AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)

func attack_toggle(value: bool) -> void:
	attacking = value

func hit() -> void:
	$Druid/AnimationTree.set('parameters/ExtraOneShot/request',  AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
	attacking = false

func specialAttack(value : int) -> void:
	extra_animation.animation = special_attack_dic[value]
	$Druid/AnimationTree.set('parameters/ExtraOneShot/request',  AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
