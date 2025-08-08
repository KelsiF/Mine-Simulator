extends Node3D

signal reward_ore
signal remove_block
signal open_playmenu

var block = preload("res://scenes/block.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_blocks(25)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("recreate"):
		remove_block.emit()
		await get_tree().create_timer(0.25).timeout
		spawn_blocks(25)

func spawn_blocks(count: int):
	#var i = 0
	
	var rng = RandomNumberGenerator.new()
	
	#while i < count:
	for i in range(count):
		var instance = block.instantiate()
		var x = rng.randf_range(-39.85, 27.74)
		var z = rng.randf_range(-77.14, -46.08)
		
		instance.position = Vector3(x, 1.6, z)
	
		add_child(instance)
		instance.block_destroy.connect(_on_block_destroy)
		instance.add_to_group("BLOCKS")
		i += 1
		#print(i, " ", count)


func _on_block_spawn_block() -> void:
	spawn_blocks(1)

func _on_block_destroy(rn):
	reward_ore.emit(rn)
	spawn_blocks(1)

func _on_miner_npc_play() -> void:
	open_playmenu.emit()
