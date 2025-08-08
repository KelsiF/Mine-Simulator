extends Control

signal success_buy

var slot = preload("res://scenes/gui/shop_slot.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#print(get_child(0).get_child(0))
	for i in range(9):
		var instance = slot.instantiate()
	#	print(i)
		get_child(0).get_child(1).get_child(0).add_child(instance)
		instance.buy_pickaxe.connect(_on_buy)
		#print(instance.name)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_buy(pickaxe, cost):
	success_buy.emit(pickaxe, cost)


func _on_button_pressed() -> void:
	$PanelContainer2/Close/Button.button_pressed = false
	self.hide()
