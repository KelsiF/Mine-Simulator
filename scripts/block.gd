extends StaticBody3D

signal block_destroy

@onready var player = get_parent().get_node("Player")

@export var attack_cooldown: float = 1.0
var attack_timer: float = 0.0
var can_attack = true

var onRadius = false
var maxhp = 5
var hp = 2
var level = 0
var ore = "stone" # текущая руда

var ore_list = ["stone", "coal", "iron", "gold", "diamond"] # список руд
var oremesh_list = [^"res://models/meshes/stone.res", ^"res://models/meshes/coal.res", ^"res://models/meshes/iron.res", ^"res://models/meshes/gold.res", ^"res://models/meshes/diamond.res"]
var hp_list = [5, 7.5, 11.25, 17, 25.5] # базовое здоровье для каждой руды
# Здоровье руды считается по формуле { (базовое здоровье * уровень)/2 }

var rng = RandomNumberGenerator.new()
var rn = 0 # id руды

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	get_parent().remove_block.connect(_on_remove_block)
	
	level = player.cave_level
	var max_ore = level-1
	
	print("max_Ore " + str(max_ore))
	print("level" + str(level))
	
	rn = rng.randi_range(0, max_ore)
	print("rn " + str(rn))
	ore = ore_list[rn]
	maxhp = hp_list[rn]
	hp = maxhp
	$Label3D.text = str(hp) + "/" + str(maxhp)
	
	# загрузка модели
	$MeshInstance3D.mesh = load(oremesh_list[rn])


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if attack_timer > 0:
		can_attack = false
		attack_timer -= delta
	
	if attack_timer <= 0:
		can_attack = true


func _on_collision_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed == true:
			if onRadius == true:
				if can_attack == true:
					attack()
				else:
					print("перезарядка кд")



func _on_radius_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		onRadius = true



func _on_radius_body_exited(body: Node3D) -> void:
	if body.name == "Player":
		onRadius = false

func attack():
	var blocks = get_tree().get_nodes_in_group("BLOCKS").size()
	hp = hp - player.damage
	$Label3D.text = str(hp) + "/" + str(maxhp)
	if hp <= 0:
		await call_deferred("queue_free")
		#print("блоков осталось: ", blocks-1)
		block_destroy.emit(rn)
	attack_timer = attack_cooldown

func _on_remove_block():
	await call_deferred("queue_free")
