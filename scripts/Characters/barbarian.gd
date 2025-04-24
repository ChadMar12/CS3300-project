extends Node3D

@onready var move_state_machine = $Barbarian/AnimationTree.get("parameters/MoveStateMachine/playback")
@onready var attack_state_machine = $Barbarian/AnimationTree.get('parameters/AttackStateMachine/playback')

var attacking = false
var squash_and_stretch = 1.0:
	set(value):
		squash_and_stretch = value
		var negative = 1.0 + (1.0 - squash_and_stretch)
		scale = Vector3(negative,squash_and_stretch,negative)

func set_move_state(state_name : String) -> void:
	move_state_machine.travel(state_name)

func attack_toggle(value: bool) -> void:
	attacking = value

func attack() -> void:
	if not attacking:
		attack_state_machine.travel('1H_Melee_Attack_Chop' if $Barbarian/SecondAttackTimer.time_left else '1H_Melee_Attack_Slice_Diagonal')
		$Barbarian/AnimationTree.set('parameters/AttackOneShot/request',  AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)

func can_damage(value : bool) -> void:
	$"Barbarian/Rig/Skeleton3D/1H_Axe/1H_Axe".can_damage = value
	
func hit() -> void:
	$Barbarian/AnimationTree.set('parameters/ExtraOneShot/request',  AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
	attacking = false
