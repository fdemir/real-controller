extends Node

@onready var animation_tree: AnimationTree = $"../AnimationTree"
@onready var playback = animation_tree.get("parameters/playback")
@onready var player: CharacterBody3D = $".."

var target_direction: Vector2 = Vector2.ZERO

func _process(delta: float) -> void:
	if player == null or animation_tree == null:
		return

	var is_sprinting = player.is_sprinting
	var is_walking = player.is_walking

	var target_blend = Vector2(player.input_dir.x, -player.input_dir.y)

	# Update blend positions for all movement types
	var current_walk = animation_tree.get("parameters/Locomotion/WalkBlend/blend_position")
	var smooth_walk = current_walk.lerp(target_blend, delta * 10.0)
	animation_tree.set("parameters/Locomotion/WalkBlend/blend_position", smooth_walk)

	var current_run = animation_tree.get("parameters/Locomotion/RunBlend/blend_position")
	var smooth_run = current_run.lerp(target_blend, delta * 10.0)
	animation_tree.set("parameters/Locomotion/RunBlend/blend_position", smooth_run)

	var current_sprint = animation_tree.get("parameters/Locomotion/SprintBlend/blend_position")
	var smooth_sprint = current_sprint.lerp(target_blend, delta * 10.0)
	animation_tree.set("parameters/Locomotion/SprintBlend/blend_position", smooth_sprint)

	var target_walk_run = 0.0 if is_walking else 1.0
	var current_walk_run = animation_tree.get("parameters/Locomotion/WalkRunBlend/blend_amount")
	var smooth_walk_run = lerp(current_walk_run, target_walk_run, delta * 8.0)
	animation_tree.set("parameters/Locomotion/WalkRunBlend/blend_amount", smooth_walk_run)

	var is_moving_backward = player.input_dir.y > 0
	var target_speed = 1.0 if (is_sprinting and not is_moving_backward) else 0.0
	var current_speed = animation_tree.get("parameters/Locomotion/SpeedBlend/blend_amount")
	var smooth_speed = lerp(current_speed, target_speed, delta * 8.0)
	animation_tree.set("parameters/Locomotion/SpeedBlend/blend_amount", smooth_speed)
