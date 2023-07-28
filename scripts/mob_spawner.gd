extends Node2D

@export var DAYMOB: PackedScene = preload("res://scenes/game/enemy/base_day_mob.tscn")
@export var NIGHTMOB: PackedScene = preload("res://scenes/game/enemy/base_night_mob.tscn")

var mob_to_spawn
var is_day

@onready var spawn_timer = $SpawnTimer
var can_spawn: bool = true
var outer_radius: float = 600
var inner_radius: float = 500

signal spawn

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	handle_input(delta)

func handle_input(delta):
	if can_spawn and Input.is_action_pressed("temporary_action"):
		can_spawn = false
		var horde = generate_horde()
		spawn_horde(horde)

func generate_horde() -> Array:
	# Generate an array containing different enemy scenes randomly
	var possible_enemies = [DAYMOB, NIGHTMOB]
	var test_horde = []
	
	for number in range(50):  # You can modify the number of enemies in the horde here
		var random_index = randi() % possible_enemies.size()
		test_horde.append(possible_enemies[random_index])
	
	print("Horde generated!")
	return test_horde

func spawn_horde(input_array: Array):
	for enemy in input_array:
		spawn_enemy(enemy)
		print("Horde spawned!")

func spawn_enemy(enemy: PackedScene):
	var spawn_enemy = enemy.instantiate()
	self.get_parent().add_child(spawn_enemy)
	spawn_enemy.global_position = get_random_pos_in_ring(outer_radius, inner_radius)
	spawn_timer.start()
	print("Enemy spawned!")

func get_random_pos_in_ring(outer_radius: float, inner_radius: float) -> Vector2:
	var x1 = randf_range(-1, 1)
	var x2 = randf_range(-1, 1)

	while x1 * x1 + x2 * x2 >= 1:
		x1 = randf_range(-1, 1)
		x2 = randf_range(-1, 1)

	var random_pos_on_unit_circle = Vector2(2 * x1 * sqrt(1 - x1 * x1 - x2 * x2),
											2 * x2 * sqrt(1 - x1 * x1 - x2 * x2))

	var random_pos_in_ring = random_pos_on_unit_circle * randf_range(inner_radius, outer_radius)

	return random_pos_in_ring


func _on_spawn_timer_timeout():
	can_spawn = true
