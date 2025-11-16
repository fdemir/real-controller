extends Node

@onready var animation_tree: AnimationTree = $"../AnimationTree"
@onready var player: CharacterBody3D = $".."
@onready var camera: Camera3D = $"../Camera3D"

var target_direction: Vector2 = Vector2.ZERO

func _process(delta: float) -> void:
	if player == null or animation_tree == null:
		return

	var target_blend = Vector2(player.input_dir.x, -player.input_dir.y)
	var current_blend = animation_tree.get("parameters/Movement/blend_position")

	var smooth_blend = current_blend.lerp(target_blend, delta * 10.0)
	animation_tree.set("parameters/Movement/blend_position", smooth_blend)
