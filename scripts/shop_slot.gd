extends TextureRect

signal buy_pickaxe

@onready var player = get_parent().get_parent().get_parent().get_parent().get_parent()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var item = str(self.name)
	
	# Установка текстуры и цены
	match item:	
		"ShopSlot":
			$TextureRect.texture = load("res://textures/wooden_pickaxe_sm.png")
			$Button.text = "КУПЛЕНО"
		"@TextureRect@2":
			$TextureRect.texture = load("res://textures/stone_pickaxe_sm.png")
			$Button.text = "КУПИТЬ\n20 монет"
		"@TextureRect@3":
			$TextureRect.texture = load("res://textures/iron_pickaxe_sm.png")
			$Button.text = "КУПИТЬ\n50 монет"
		"@TextureRect@4":
			$TextureRect.texture = load("res://textures/golden_pickaxe_sm.png")
			$Button.text = "КУПИТЬ\n75 монет"
		"@TextureRect@5":
			$TextureRect.texture = load("res://textures/diamond_pickaxe_sm.png")
			$Button.text = "КУПИТЬ\n100 монет"
		_:
			$TextureRect.texture = load("res://textures/emtpy_slot.png")
			$Button.text = "N/A"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_button_pressed() -> void:
	var item = str(self.name)
	
	match item:
		"ShopSlot":
			print("Кирка уже есть...")
		"@TextureRect@2":
			if player.money >= 20:
				buy_pickaxe.emit("stone_pickaxe", 20)
		"@TextureRect@3":
			if player.money >= 50:
				buy_pickaxe.emit("iron_pickaxe", 50)
		"@TextureRect@4":
			if player.money >= 75:
				buy_pickaxe.emit("golden_pickaxe", 75)
		"@TextureRect@5":
			if player.money >= 75:
				buy_pickaxe.emit("diamond_pickaxe", 75)
