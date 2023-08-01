class_name Inventory 
extends Resource

signal inventory_changed

@export var _items = Array(): set = set_items, get = get_items

# Setter of '_items' array
func set_items(new_items: Array) -> void:
	_items = new_items
	emit_signal("inventory_changed", self)


# Getter of '_items' array
func get_items() -> Array:
	return _items


# Get item of specific index from the inventory
func get_item(index: int) -> Item:
	return _items[index]


# Add items to the inventory
func add_item(item_name: String, quantity: int) -> void:
	if quantity <= 0: # Check if the given quantity is positive
		return
	
	var item: Item = ItemDatabase.get_item(item_name)
	if not item: # Check if the item being added is present in the database
		return
	
	var remaining_quantity: int = quantity
	var max_stack_size: int = item.max_stack_size if item.stackable else 1
	
	if item.stackable: # Check if the item is stackable
		for i in range(_items.size()):
			if remaining_quantity == 0: # Check if there are still items to add
				break
			
			var inventory_item = _items[i] # Current item reference
			
			if  inventory_item.item_reference.name != item.name: # Check if items match
				continue
			
			if inventory_item.quantity < max_stack_size: # Check if enough space in the stack
				# Add item to the inventory and determine how many are left (not added to a stack)
				var original_quantity: int = inventory_item.quantity
				inventory_item.quantity = min(original_quantity + remaining_quantity, max_stack_size)
				remaining_quantity -= inventory_item.quantity - original_quantity
				
		
		# Add new item stack
		while remaining_quantity > 0:
			var new_item: Dictionary = {
				item_reference = item,
				quantity = min(remaining_quantity, max_stack_size)
			}
			_items.append(new_item)
			remaining_quantity -= new_item.quantity
			
		# Emit the signal that the inventory has changed
		emit_signal("inventory_changed", self)


# Remove items from the inventory
func remove_item(item_name: String, quantity_to_remove: int) -> void:
	if quantity_to_remove <= 0: # Check if the given quantity of items to remove is positive
		return
	
	var item_to_find: Item = ItemDatabase.get_item(item_name)
	
	if not item_to_find: # Check if the item is present in the database
		return
	
	# Find the item in the _items array
	for i in range(_items.size()):
		var inventory_item = _items[i]
		if  inventory_item.item_reference.name != item_name: # Check if items match
			continue
		# If found, decrease the quantity
		inventory_item.quantity -= quantity_to_remove
		
		if inventory_item.quantity <= 0: # Check if there are any items left
			_items.erase(inventory_item)
