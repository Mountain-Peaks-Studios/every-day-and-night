extends CanvasLayer


var CurrItemId = 0
var select = 0


func _on_exit_pressed():
	get_node("Shop Anim").play("TransOut")
	get_tree().paused = false



func switch_item(select):
	for i in range(GlobalItems.size()):
		if select == i:
			CurrItemId = select
			get_node("Control/Item").play(GlobalItems.items[CurrItemId]["Name"])
			get_node("Control/Name").text = GlobalItems.items[CurrItemId]["Name"]
			get_node("Control/Descripton").text = str(GlobalItems.items[CurrItemId]["Cost"])
			get_node("Control/Descripton").text += "\n" + GlobalItems.items[CurrItemId]["Des"]

func _on_next_pressed():
	switch_item(CurrItemId+1)


func _on_previous_pressed():
	switch_item(CurrItemId-1)


func _on_buy_pressed():
	pass # Replace with function body.
