extends Node2D

func _process(delta):
	if Input.is_action_just_pressed("next"):
		get_tree().change_scene_to_file("res://levels/level_2.tscn")

