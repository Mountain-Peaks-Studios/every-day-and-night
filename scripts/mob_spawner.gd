extends Node2D

@export var DAYMOB: PackedScene = preload("res://scenes/game/enemy/base_day_mob.tscn")
@export var NIGHTMOB: PackedScene = preload("res://scenes/game/enemy/base_night_mob.tscn")

var mob_to_spawn
var is_day

@onready var spawn_timer = $SpawnTimer
var can_spawn: bool = true

signal spawn

# Called when the node enters the scene tree for the firt time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	handle_input()

func handle_input():
	if Input.is_action_pressed("temporary_action"):
		var horde = generate_horde()
		spawn_horde(horde)

func generate_horde() -> Array:
	var test_horde = [DAYMOB, DAYMOB]
	return test_horde


func spawn_horde(input_array: Array):
	for enemy in input_array:
		spawn_enemy(enemy)


func spawn_enemy(enemy: PackedScene):
	
	if can_spawn:
		var spawn_enemy = enemy.instantiate()
		self.get_parent().add_child.call_deferred(spawn_enemy)
		spawn_enemy.global_position = self.global_position
		spawn_timer.start()
		can_spawn = false


func _on_spawn_timer_timeout():
	can_spawn = true
