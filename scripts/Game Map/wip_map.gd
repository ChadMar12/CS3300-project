extends Level

var target = null

@onready var portal_area = $mapOriginal/PortalBG_01/Area3D
@onready var portal_visual = $mapOriginal/PortalBG_01
@onready var portal_collision = portal_area.get_node("CollisionShape3D")


func deactivate_portal():
	portal_area.queue_free()
	portal_visual.hide()


func _on_area_3d_body_entered(body: Node3D) -> void:
	
	if level_manager.dun == 1:
		target = 'Dungeon1'
	elif level_manager.dun == 2:
		target = 'Dungeon2'
		deactivate_portal()
	
	
	switchLevel(target)
	
	level_manager.dun += 1
	
