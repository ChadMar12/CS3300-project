extends Control

var main_scene_path = "res://scene/game map/game_world.tscn"
var real_progress := 0.0
var display_progress := 0.0
var loading_started := false
var loading_done := false

func _ready() -> void:
	ResourceLoader.load_threaded_request(main_scene_path)
	loading_started = true

func _process(delta: float) -> void:
	if loading_started and not loading_done:
		var progress = []
		var status = ResourceLoader.load_threaded_get_status(main_scene_path, progress)

		if progress.size() > 0:
			real_progress = progress[0]

		# Smooth visual progress using interpolation
		display_progress = lerp(display_progress, real_progress, 5 * delta)

		# Clamp to 1.0 if very close to 100%
		if abs(display_progress - real_progress) < 0.01:
			display_progress = real_progress

		# Update your UI
		$progress_number.text = str(int(display_progress * 100)) + '%'

		# Optional: if you have a ProgressBar node
		#$ProgressBar.value = display_progress * 100

		if status == ResourceLoader.THREAD_LOAD_LOADED and display_progress >= 0.99:
			loading_done = true
			var scene = ResourceLoader.load_threaded_get(main_scene_path)
			get_tree().change_scene_to_packed(scene)
