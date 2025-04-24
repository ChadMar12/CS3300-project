extends Node3D
@onready var pause_menu: Control = $Pause_Menu
var paused = false
var fireball_scene: PackedScene = preload("res://scene/vfx/fireball.tscn")
@onready var player = $ProtoController

func _ready() -> void:
	
	if level_manager.saved_location == Vector3.ZERO:
		
		player.global_position = Vector3(-155.1,55.093,364.37)
	else: 
		player.global_position = level_manager.saved_location
	
	for entity in $Entities.get_children():
		if entity.has_signal('cast_spell'):
			entity.connect('cast_spell', create_fireball)

func create_fireball(type: String, pos: Vector3, direction: Vector2, size: float):
	# copy and paste this to create fireball for player
	var fireball = fireball_scene.instantiate()
	$Projectiles.add_child(fireball)
	fireball.global_position = pos
	fireball.direction = direction
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		pauseMenu()
		
func pauseMenu() -> void:
	if paused:
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		pause_menu.show()
		Engine.time_scale = 0
	
	paused = !paused
