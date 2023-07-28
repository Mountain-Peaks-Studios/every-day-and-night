extends Node2D

#const ENEMY_SCENES: Dictionary = {
#
#}

var num_enemies: int

# Children
@onready var tilemap: TileMap = $TileMap
@onready var entrance: Node2D = $Entrance
@onready var door_container: Node2D = $Doors
#@onready var enemy_positions_container: Node2D = $EnemyPositions
@onready var player_detector: Area2D = $PlayerDetector

func _ready() -> void:
#	num_enemies = enemy_positions_container.get_child_count()
	pass


func _on_enemy_killed() -> void:
	num_enemies -= 1
	if num_enemies == 0:
		_open_doors()


func _open_doors() -> void:
	if door_container.get_children() != null:
		for door in door_container.get_children():
			door.open()


func _close_entrance() -> void:
	if entrance.get_children() != null:
		for entry_position in entrance.get_children():
			
			tilemap.set_cell(0, tilemap.world_to_map(entry_position.global_position), 
			0, Vector2(6,0))
			tilemap.set_cell(0, tilemap.world_to_map(entry_position.global_position) + Vector2.DOWN,
			0, Vector2(7,0))


#func _spawn_enemies() -> void:
#	if enemy_positions_container.get_children() != null:
#		for enemy_position in enemy_positions_container.get_children():
#			var enemy: CharacterBody2D = ENEMY_SCENES.NAME.instance()
#			var __ = enemy.connect("tree_exited", self, "_on_enemy_killed")
#			enemy.global_position = enemy_position.global_position
#			call_deferred("add_child", enemy)

func _on_player_detector_body_entered(body: PhysicsBody2D) -> void:
	print("dupa")
	player_detector.queue_free()
	#_close_entrance()
#	_spawn_enemies()
