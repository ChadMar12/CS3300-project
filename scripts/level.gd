class_name Level
extends Node

var dungeonCounter = 1

const Scene = {
	'MainWorld': "res://scene/game map/game_world.tscn",
	'Dungeon1': "res://scene/Dungeon/Dungeon.tscn",
	'Dungeon2': "res://scene/Dungeon/Dungeon2.tscn"
}

func _ready():
	
	if level_manager.main_world == null:
		var main_scene = load(Scene['MainWorld'])
		level_manager.main_world = main_scene.instantiate()
		get_tree().get_root().add_child(level_manager.main_world)

func switchLevel(target: String):
	var tree = get_tree()
	var root = tree.get_root()
	var current_scene = tree.current_scene

	if current_scene:
		root.remove_child(current_scene)
		
	if target == "MainWorld":

		if level_manager.main_world:
			root.add_child(level_manager.main_world)
			tree.set_current_scene(level_manager.main_world)
			
			# Need to work on this some more
			var player = level_manager.main_world.get_node('ProtoController')
			if player:
				
				player.global_transform.origin = level_manager.spawn_location
				
		
		else:
	
			var main_scene = load(Scene['MainWorld'])
			level_manager.main_world = main_scene.instantiate()
			root.add_child(level_manager.main_world)
			tree.set_current_scene(level_manager.main_world)
			
			
		if current_scene and current_scene != level_manager.main_world:
			current_scene.queue_free()
	else:

		if current_scene == level_manager.main_world:
			root.remove_child(level_manager.main_world)
		else:
			current_scene.queue_free()

		var new_scene = load(Scene[target]).instantiate()
		root.add_child(new_scene)
		tree.set_current_scene(new_scene)
		
		# Need to work on this some more
		var player = level_manager.main_world.get_node('ProtoController')
		if player:
			level_manager.spawn_location = Vector3(-155.1,55.093,364.37)
			
