extends CharacterBody3D

var all_items = ["wooden_pickaxe", "stone_pickaxe", "iron_pickaxe", "golden_pickaxe", "diamond_pickaxe"]
var your_items = ["wooden_pickaxe"]
var item_damage = [0, 0.5, 0.75, 1, 1.5] # without decrease: 0, 2, 3, 4.5, 6.75


var onRadius = false
var basedamage = 1
var damage = 1
var money = 0
var current_item = 1

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

@export var sens_horizontal = 0.5
#@export var sens_vertical = 0.5

@onready var camera_mount = $camera_mount

func _ready() -> void:
	damage = 1+item_damage[current_item]
	$CanvasLayer/Label.text = "v. 0.1 dev\nitem: " + all_items[current_item] + "\nbase damage: " + str(basedamage) + "\nextra damage: +" + str(item_damage[current_item])

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Input.is_action_pressed("right_click"):
		camera_mount.rotate_y(deg_to_rad(-event.relative.x+sens_horizontal))
		rotate_y(deg_to_rad(-event.relative.x+sens_horizontal/2))
		#camera_mount.rotate_x(deg_to_rad(-event.relative.y+sens_vertical))

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "up", "down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()






func _on_area_3d_body_entered(body: Node3D) -> void:
	print(body)
	if body.name == "Block":
		onRadius = true

func _on_block_on_click():
	if onRadius == true:
		print("detected")
