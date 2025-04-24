extends Node3D
@onready var pause_menu: Control = $Pause_Menu
var paused = false

@onready var player = $ProtoController

func _ready() -> void:
	
	if level_manager.saved_location == Vector3.ZERO:
		
		player.global_position = Vector3(-155.1,55.093,364.37)
	else: 
		player.global_position = level_manager.saved_location

func _process(_delta: float) -> void:
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
