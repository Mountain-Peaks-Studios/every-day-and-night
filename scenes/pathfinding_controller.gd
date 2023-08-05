class_name Pathfinder
extends Node

var a_star = AStar2D.new()
@onready var main: Node2D = get_tree().root.get_node("TempMainScene")
@onready var grid = main.get_node("Grid") # !!! Grid type missing

const DIRECTIONS = [Vector2.UP, Vector2.DOWN, Vector2.LEFT, Vector2.RIGHT]

func add_points() -> void:
	var current_id = 0
	for point in grid.grid:
		a_star.add_point(current_id, grid.gridToWorld(point)) ### to change
		current_id += 1


func get_point_id(grid_point: Vector2) -> int:
	return a_star.get_closest_point(grid.gridToWorld(grid_point))


func get_world_id(world_point: Vector2) -> int:
	return a_star.get_closest_point(grid.gridToWorld(world_point))


func get_id_world_pos(_id: int) -> Vector2:
	return a_star.get_point_position(_id)


func get_id_grid_pos(_id: int) -> Vector2:
	var world_pos = get_id_world_pos(_id)
	return grid.worldToGrid(world_pos)


func connect_point(_point: Vector2) -> void:
	var _point_id = get_point_id(_point)
	for direction in DIRECTIONS:
		var neighbor = _point + direction
		var neighbor_id = get_point_id(neighbor)
		if grid.grid.has(neighbor) and grid.grid[neighbor] == null:
			a_star.connect_points(_point_id, neighbor_id)
