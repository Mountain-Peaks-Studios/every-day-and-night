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
