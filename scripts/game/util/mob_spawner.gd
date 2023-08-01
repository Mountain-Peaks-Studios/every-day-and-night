extends Node

# Signal emitted when it's time to spawn a new enemy, can be used for on-screen-warnings
signal spawn

# The currently selected mob scene to spawn
var mob_to_spawn: PackedScene

# Flag to determine whether it's day or night
var is_day: bool = true

# Flag to control mob spawning
var can_spawn: bool = true

# The outer and inner radius for enemy spawning in the ring
var outer_radius: float = 1000
var inner_radius: float = 1000

# Timer to regulate mob spawning
@onready var spawn_timer = $SpawnTimer

# Preloaded scenes
@onready var day_mob_scene: PackedScene = preload("res://scenes/game/enemy/base_mob_day.tscn")
@onready var night_mob_scene: PackedScene = preload("res://scenes/game/enemy/base_mob_night.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	update_day_time()
	handle_input()
	#change_position(get_player_position())


#func change_position(input_position: Vector2):
#	self.position = input_position


func get_player_position() -> Vector2:
	var player_position = self.get_parent().get_node("Player").position
	return player_position


func handle_input() -> void:
	if can_spawn and Input.is_action_pressed("temporary_action"):
		can_spawn = false
		var horde = generate_horde()
		spawn_horde(horde)


func update_day_time() -> void:
	is_day = get_parent().get("is_day")


func generate_horde() -> Array:
	# Generate an array containing different enemy scenes randomly
	var possible_enemies = []
	var test_horde = []
	
	# later to be changed for day_mob_scene_1 etc.
	if is_day == true:
		possible_enemies = [day_mob_scene, day_mob_scene, day_mob_scene]
	elif is_day == false:
		possible_enemies = [night_mob_scene, night_mob_scene, night_mob_scene]
	
	for number in range(50):  # You can modify the number of enemies in the horde here
		var random_index = randi() % possible_enemies.size()
		test_horde.append(possible_enemies[random_index])
	
	print("Horde generated!")
	return test_horde


func spawn_horde(input_array: Array) -> void:
	for enemy in input_array:
		spawn_enemy(enemy)
		print("Horde spawned!")


func spawn_enemy(enemy: PackedScene) -> void:
	var spawn_enemy = enemy.instantiate()
	self.get_parent().add_child(spawn_enemy)
	spawn_enemy.global_position = get_random_pos_in_ring(outer_radius, inner_radius) + get_player_position()
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


func get_random_pos_in_circle(radius: float) -> Vector2:
	var x1 = randf_range(-1, 1)
	var x2 = randf_range(-1, 1)

	while x1 * x1 + x2 * x2 >= 1:
		x1 = randf_range(-1, 1)
		x2 = randf_range(-1, 1)

	var random_pos_on_unit_circle = Vector2(2 * x1 * sqrt(1 - x1 * x1 - x2 * x2),
											2 * x2 * sqrt(1 - x1 * x1 - x2 * x2))

	return random_pos_on_unit_circle * randf_range(0, radius)


func _on_spawn_timer_timeout() -> void:
	can_spawn = true
