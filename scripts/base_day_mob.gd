extends "res://scripts/base_mob_behaviour.gd"

var day_speed = 250
var day_isNight = 0

func _ready():
	self.speed = day_speed
	self.isNight = day_isNight

func _physics_process(delta):
	update_target()
	update_health()
	move_towards_target()
