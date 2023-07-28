extends Node2D

@export var DAYMOB: PackedScene = preload("res://scenes/game/enemy/base_day_mob.tscn")
@export var NIGHTMOB: PackedScene = preload("res://scenes/game/enemy/base_night_mob.tscn")

var mob_to_spawn
var is_day

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	spawn_enemy()


func spawn_enemy():
	
	is_day = get_parent().get("is_day")
	
	if is_day:
		mob_to_spawn = DAYMOB.instantiate()
	else:
		mob_to_spawn = NIGHTMOB.instantiate()
	
	self.get_parent().add_child(mob_to_spawn)
	mob_to_spawn.global_position = self.global_position
