extends Node2D

# Constants
const TICKS_IN_CYCLE = 60
const HALF_CYCLE = TICKS_IN_CYCLE / 2

# Children
@onready var player = $Player
@onready var hud = $HUD

# Day/Night cycle
var current_tick = 0
var ticks_total = 0
var is_day = true

func _process(delta):
	if Input.is_action_just_pressed("temporary_action"):
		time_tick()

# Move time forward by one tick
func time_tick():
	current_tick = (current_tick + 1) % (TICKS_IN_CYCLE + 1)
	ticks_total += 1
	
	is_day = current_tick < HALF_CYCLE

	# Modify UI
	hud.on_clock_tick(current_tick, TICKS_IN_CYCLE, ticks_total, is_day)
