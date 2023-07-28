extends Node2D

const SPAWN_ROOMS: Array = [preload("res://start_room_0.tscn")]
const INTERMEDIATE_ROOMS: Array = [preload("res://room_0.tscn"), preload("res://room_1.tscn")]
const END_ROOMS: Array = [preload("res://end_room_0.tscn")]

const TILE_SIZE: int = 16
const FLOOR_TILE_ATLAS = Vector2(3,1)
const RIGHT_WALL_TILE_ATLAS = Vector2(3,5)
const LEFT_WALL_TILE_ATLAS = Vector2(4,5)

@export var num_levels: int = 5

@onready var player: CharacterBody2D = get_parent().get_node("Player")

func _ready() -> void:
	_spawn_rooms()
	
func _spawn_rooms() -> void:
	var previous_room: Node2D
	
	for i in num_levels:
		var room: Node2D
		
		if i == 0:
			room = SPAWN_ROOMS[randi() % SPAWN_ROOMS.size()].instantiate()
			player.position = room.get_node("PlayerSpawnPos").position
		else:
			if i == num_levels - 1:
				room = END_ROOMS[randi() % END_ROOMS.size()].instantiate()
			else:
				room = INTERMEDIATE_ROOMS[randi() % INTERMEDIATE_ROOMS.size()].instantiate()
				
			var previous_room_tilemap: TileMap = previous_room.get_node("TileMap")
			var previous_room_door: StaticBody2D = previous_room.get_node("Doors/Door")
			var exit_tile_pos: Vector2 = (previous_room_tilemap.local_to_map(previous_room_door.position)
			+ Vector2i.UP) * 0.2
			
			var corridor_height: int = randi() % 5 + 2
			for y in corridor_height:
				previous_room_tilemap.set_cell(0, exit_tile_pos + Vector2(-2, -y), 0, LEFT_WALL_TILE_ATLAS)
				previous_room_tilemap.set_cell(0, exit_tile_pos + Vector2(-1, -y), 0, FLOOR_TILE_ATLAS)
				previous_room_tilemap.set_cell(0, exit_tile_pos + Vector2(0, -y), 0, FLOOR_TILE_ATLAS)
				previous_room_tilemap.set_cell(0, exit_tile_pos + Vector2(1, -y), 0, RIGHT_WALL_TILE_ATLAS)
			
			var room_tilemap: TileMap = room.get_node("TileMap")
			print(Vector2.LEFT * room_tilemap.local_to_map(room.get_node("Entrance/RightTile").position).x * TILE_SIZE)
			room.position = (previous_room_door.global_position 
			+ Vector2.UP * room_tilemap.get_used_rect().size.y * TILE_SIZE
			+ Vector2.UP * (5 + corridor_height) * TILE_SIZE * 5
			+ Vector2.LEFT * room_tilemap.local_to_map(room.get_node("Entrance/RightTile").position).x * TILE_SIZE)
			
		add_child(room)
		previous_room = room
