extends Node3D

signal anim_end

var pickaxe = [^"res://models/meshes/pickaxe/wooden_pickaxe.res", ^"res://models/meshes/pickaxe/stone_pickaxe.res", ^"res://models/meshes/pickaxe/iron_pickaxe.res", ^"res://models/meshes/pickaxe/gold_pickaxe.res", ^"res://models/meshes/pickaxe/diamond_pickaxe.res"]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_player_change_pickaxe(current_item) -> void:
	$"Node/Right Arm2/Right Arm/Pickaxe/model".mesh = load(pickaxe[current_item])


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	anim_end.emit()



func _on_animation_player_animation_started(anim_name: StringName) -> void:
	if anim_name == "mine":
		$AnimationPlayer.speed_scale = 1.25
	else:
		$AnimationPlayer.speed_scale = 1.0
