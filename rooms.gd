extends Node2D

const SPAWN_ROOMS: Array = [preload("res://start_room_0.tscn")]
const INTERMEDIATE_ROOMS: Array = [preload("res://room_0.tscn"), preload("res://room_1.tscn")]
const END_ROOMS: Array = [preload("res://end_room_0.tscn")]

const TILE_SIZE: int = 80
const FLOOR_TILE_ATLAS = Vector2(3,1)
const RIGHT_WALL_TILE_ATLAS = Vector2(3,5)
const LEFT_WALL_TILE_ATLAS = Vector2(4,5)

@export var num_levels: int = 5

@onready var player: CharacterBody2D = get_parent().get_node("Player")

func _ready() -> void:
	_spawn_rooms()
	
func _spawn_rooms() -> void:
	pass
