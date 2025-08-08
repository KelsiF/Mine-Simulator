extends Control

signal upgrade_level

@onready var player = get_parent()

var level_cost = 50

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text_level()
	print(player)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_play_button_pressed() -> void:
	$PanelContainer/PlayButton.button_pressed = false
	player.position = Vector3(-38.86, 2, -59.70)
	self.hide()



func _on_close_button_pressed() -> void:
	$PanelContainer/CloseButton.button_pressed = false
	self.hide()

func text_level():
	$PanelContainer/UpgradeButton.text = "Улучшить шахту\n (" + str(player.cave_level) + " Уровень) -> (" + str(player.cave_level+1) + " уровень)"
	$PanelContainer/RequiredLevel.text = "Текущий уровень: " + str(player.cave_level) + "\nТребуется монет: " + str(level_cost)


func _on_upgrade_button_pressed() -> void:
	$PanelContainer/UpgradeButton.button_pressed = false
	
	if player.money >= level_cost:
		upgrade_level.emit(level_cost)


func _on_player_update_ui_play() -> void:
	text_level()
