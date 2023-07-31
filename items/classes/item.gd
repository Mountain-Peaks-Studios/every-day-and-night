class_name Item 
extends Resource

@export var name: String
@export var stackable: bool = false
@export var max_stack_size: int = 1

enum ItemType { COIN, POTION, TRINKET }
@export var type: ItemType
@export var sprite: Texture
