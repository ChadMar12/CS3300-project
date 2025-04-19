extends CharacterBody3D

@export var can_move : bool = true				## Can we move around?
@export var has_gravity : bool = true			## Are we affected by gravity?
@export var can_jump : bool = true				## Can we press to jump?
@export var can_sprint : bool = false			## Can we hold to run?
@export var can_freefly : bool = false			## Can we press to enter freefly mode (noclip)?

@export_group("Speeds")							
@export var look_speed : float = 0.002			## Look around rotation speed.
@export var base_speed : float = 7.0			## Normal speed.
@export var jump_velocity : float = 4.5			## Speed of jump.
@export var sprint_speed : float = 10.0			## How fast do we run?
@export var freefly_speed : float = 25.0		## How fast do we freefly?

@export_group("Input Actions")				
@export var input_left : String = "ui_left"		## Name of Input Action to move Left.
@export var input_right : String = "ui_right"	## Name of Input Action to move Right.
@export var input_forward : String = "ui_up"	## Name of Input Action to move Forward.
@export var input_back : String = "ui_down"		## Name of Input Action to move Backward.
@export var input_jump : String = "ui_accept"	### Name of Input Action to Jump.
@export var input_sprint : String = "sprint"	## Name of Input Action to Sprint.
@export var input_freefly : String = "freefly"	## Name of Input Action to toggle freefly mode.


var mouse_captured : bool = false
var look_rotation : Vector2
var move_speed : float = 0.0
var freeflying : bool = false

## IMPORTANT REFERENCES
@onready var head: Node3D = $Head
@onready var collider: CollisionShape3D = $Collider

@onready var ui = $"In game UI"
var health = 100

@onready var skin = null

@onready var characters_types = {
	'Knight'    : $Characters/Knight,
	'Mage'      : $Characters/Mage,
	'Barbarian' : $Characters/Barbarian,
	'Druid'		: $Characters/Druid,
	'Rouge'		: $Characters/Rouge
}

func _ready() -> void:
	
	var type = level_manager.character_selected 
	character_load(type)
	
	check_input_mappings()
	look_rotation.y = rotation.y
	look_rotation.x = head.rotation.x
	
	ui.setup(health)

##This funciton will load the character based on the selection that the 
##player has choosen.
func character_load(type : String):

	match type:
		'Knight':
			skin = characters_types['Knight']
		'Mage':
			skin = characters_types['Mage']
		'Barbarian':
			skin = characters_types['Barbarian']
		'Druid':
			skin = characters_types['Druid']
		'Rouge':
			skin = characters_types['Rouge']
		
	unload_character_scene(type) # Function to unload the other scene's from memory
		   

## This function unloads the character scene that is not being used to save on memory
func unload_character_scene(type):
	
	for character_type in characters_types:
		if character_type != type:
			characters_types[character_type].queue_free()  

func _unhandled_input(event: InputEvent) -> void:
	
	# Mouse capturing
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		capture_mouse()
		
	if Input.is_key_pressed(KEY_ESCAPE):
		release_mouse()
	
	# Look around
	if mouse_captured and event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * look_speed))
		head.rotate_x(deg_to_rad(-event.relative.y * look_speed))
		head.rotation.x = clamp(head.rotation.x, deg_to_rad(-90), deg_to_rad(45))
		
		#rotate_look(event.relative)
	
	# Toggle freefly mode
	if can_freefly and Input.is_action_just_pressed(input_freefly):
		if not freeflying:
			enable_freefly()
		else:
			disable_freefly()

func _physics_process(delta: float) -> void:
	
	ability_logic()
	
	# If freeflying, handle freefly and nothing else
	if can_freefly and freeflying:
		var input_dir := Input.get_vector(input_left, input_right, input_forward, input_back)
		var motion := (head.global_basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		motion *= freefly_speed * delta
		move_and_collide(motion)
		return
	
	# Apply gravity to velocity
	if has_gravity:
		if not is_on_floor():
			velocity += get_gravity() * delta

	# Apply jumping
	if can_jump:
		if Input.is_action_just_pressed(input_jump) and is_on_floor():
			velocity.y = jump_velocity
			
	# Modify speed based on sprinting
	if can_sprint and Input.is_action_pressed(input_sprint):
			move_speed = sprint_speed
			skin.set_move_state('Running_A')
	else:
		move_speed = base_speed
		skin.set_move_state('Walking_A')

	# Apply desired movement to velocity
	if can_move:
		var input_dir := Input.get_vector(input_left, input_right, input_forward, input_back)
		var move_dir := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		
		# We have the jumping code working here but I do not like it, We need to find a way to refactor this code
		if not is_on_floor():
			skin.set_move_state('Jump_Idle')
		elif move_dir:
			velocity.x = move_dir.x * move_speed
			velocity.z = move_dir.z * move_speed
		else:
			velocity.x = move_toward(velocity.x, 0, move_speed)
			velocity.z = move_toward(velocity.z, 0, move_speed)
			skin.set_move_state('Idle')
	else:
		velocity.x = 0
		velocity.y = 0
		
	# Use velocity to actually move
	move_and_slide()

func enable_freefly():
	collider.disabled = true
	freeflying = true
	velocity = Vector3.ZERO

func disable_freefly():
	collider.disabled = false
	freeflying = false

func capture_mouse():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	mouse_captured = true

func release_mouse():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	mouse_captured = false

func ability_logic() -> void:
	if Input.is_action_just_pressed('ability'):
		skin.attack()

func can_damage(value : bool):
	$"Characters/Knight/Knight/Rig/Skeleton3D/1H_Sword/1H_Sword".can_damage(value)
	

## Checks if some Input Actions haven't been created.
## Disables functionality accordingly.
func check_input_mappings():
	if can_move and not InputMap.has_action(input_left):
		push_error("Movement disabled. No InputAction found for input_left: " + input_left)
		can_move = false
	if can_move and not InputMap.has_action(input_right):
		push_error("Movement disabled. No InputAction found for input_right: " + input_right)
		can_move = false
	if can_move and not InputMap.has_action(input_forward):
		push_error("Movement disabled. No InputAction found for input_forward: " + input_forward)
		can_move = false
	if can_move and not InputMap.has_action(input_back):
		push_error("Movement disabled. No InputAction found for input_back: " + input_back)
		can_move = false
	if can_jump and not InputMap.has_action(input_jump):
		push_error("Jumping disabled. No InputAction found for input_jump: " + input_jump)
		can_jump = false
	if can_sprint and not InputMap.has_action(input_sprint):
		push_error("Sprinting disabled. No InputAction found for input_sprint: " + input_sprint)
		can_sprint = false
	if can_freefly and not InputMap.has_action(input_freefly):
		push_error("Freefly disabled. No InputAction found for input_freefly: " + input_freefly)
		can_freefly = false
