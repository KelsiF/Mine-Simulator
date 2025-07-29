extends Node3D

signal play

var onRadius = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_radius_body_entered(body: Node3D) -> void:
	onRadius = true



func _on_radius_body_exited(body: Node3D) -> void:
	onRadius = false


func _on_collision_click_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT or event.button_index == MOUSE_BUTTON_RIGHT and event.pressed == true:
			if onRadius == true:
				play.emit()
