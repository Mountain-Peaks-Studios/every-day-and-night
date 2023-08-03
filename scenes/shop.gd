extends CanvasLayer


var CurrItemId = 0
var select = 0

var inventory = preload("res://items/inventory.gd").new()
var coins = preload("res://scripts/game/player/player_controller.gd").new()
var player_coins = 100


func _on_exit_pressed():
	get_node("Shop Anim").play("TransOut")
	get_tree().paused = false



func switch_item(select):
	for i in range(len(ItemDatabase.items)):
		if select == i:
			CurrItemId = select
			get_node("Control/Item").play(ItemDatabase.items[CurrItemId]["name"])
			get_node("Control/Name").text = ItemDatabase.items[CurrItemId]["name"]
			get_node("Control/Descripton").text = str(ItemDatabase.items[CurrItemId]["cost"])
			#get_node("Control/Descripton").text += "\n" + ItemDatabase.items[CurrItemId]["des"]

func _on_next_pressed():
	switch_item(CurrItemId+1)


func _on_previous_pressed():
	switch_item(CurrItemId-1)


func _on_buy_pressed():
	if player_coins >= ItemDatabase.items[CurrItemId]["cost"]:
		coins.add_coins(-ItemDatabase.items[CurrItemId]["cost"])
		inventory.add_item(ItemDatabase.items[CurrItemId], 1)
