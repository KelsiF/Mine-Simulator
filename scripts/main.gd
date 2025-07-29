extends Node3D

var block = preload("res://scenes/block.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_blocks(25)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

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
		instance.add_to_group("BLOCKS")
		i += 1
		print(i, " ", count)


func _on_block_spawn_block() -> void:
	spawn_blocks(1)


func _on_miner_npc_play() -> void:
	$Player.position = Vector3(-38.86, 2, -59.70)
