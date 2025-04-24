extends Node3D

@onready var move_state_machine = $Rogue/AnimationTree.get('parameters/MoveStateMachine/playback')

var attacking = false

var squash_and_stretch = 1.0:
	set(value):
		squash_and_stretch = value
		var negative = 1.0 + (1.0 - squash_and_stretch)
		scale = Vector3(negative,squash_and_stretch,negative)

func set_move_state(state_name : String) -> void:
	move_state_machine.travel(state_name)

func attack() -> void:
	$Rogue/AnimationTree.set('parameters/AttackOneShot/request',  AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)

func attack_toggle(value: bool) -> void:
	attacking = value
	
func can_damage(value : bool) -> void:
	$Rogue/Rig/Skeleton3D/Knife/Knife.can_damage = value

func hit() -> void:
	$Rogue/AnimationTree.set('parameters/ExtraOneShot/request',  AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
	attacking = false
