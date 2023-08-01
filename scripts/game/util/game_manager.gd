extends Node

signal player_initialised

var player

# Update every frame
func _process(delta: float) -> void:
	if not player:
		initialise_player()
		return


# Get the reference to the player
func initialise_player() -> void:
	player = get_tree().get_root().get_node("/root/Main/Player")
	if not player:
		return
	
	emit_signal("player_initialised", player)
	
	# Connect to inventory_changed signal
	player.inventory.connect("inventory_changed", self, "_on_player_inventory_changed")
	
	# Load inventory from the disc
#	var existing_inventory = load("user://inventory.tres")
#	if existing_inventory:
#		player.inventory.set_items(existing_inventory.get_items())


# Perform after player's inventory changes
func _on_player_inventory_changed(inventory: Resource) -> void:
	# Save the inventory to file
#	ResourceSaver.save(inventory, "user://inventory.tres")
	pass
