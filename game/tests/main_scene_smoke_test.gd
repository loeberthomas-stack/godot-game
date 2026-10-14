# Smoke test: the project's main scene is set, loads, and contains the placeholder.
extends GdUnitTestSuite


func _main_scene_path() -> String:
	return ProjectSettings.get_setting("application/run/main_scene", "")


func test_main_scene_setting_points_to_existing_scene() -> void:
	var path := _main_scene_path()
	assert_str(path).is_not_empty()
	assert_bool(ResourceLoader.exists(path)).is_true()


func test_main_scene_instantiates() -> void:
	var scene := load(_main_scene_path()) as PackedScene
	assert_object(scene).is_not_null()
	var root: Node = auto_free(scene.instantiate())
	assert_object(root).is_not_null()


func test_main_scene_has_placeholder_label() -> void:
	var scene := load(_main_scene_path()) as PackedScene
	var root: Node = auto_free(scene.instantiate())
	assert_object(root.get_node_or_null("PlaceholderLabel")).is_instanceof(Label)
