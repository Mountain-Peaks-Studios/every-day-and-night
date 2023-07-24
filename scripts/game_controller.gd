extends Node2D

#children
@onready var player = $Player
@onready var hud = $HUD

#day/night cycle
var ticks_in_cycle = 60 # no. of ticks in a cycle
var current_tick = 0 # tick of the cycle
var ticks_total = 0 # total no. of ticks since the run started
var is_day = true

func _process(delta):
	if Input.is_action_just_pressed("temporary_action"):
		time_tick()

# move time forward by one tick
func time_tick():
	current_tick += 1
	ticks_total += 1
	if current_tick > ticks_in_cycle: # reset the clock once the night ends
		current_tick = 0
		ticks_total -= 1
	if current_tick >= 0 and current_tick < (ticks_in_cycle/2): # day bool
		is_day = true
	elif current_tick >= 30 and current_tick <= ticks_in_cycle: # night bool
		is_day = false
	
	# modify UI
	hud.on_clock_tick(current_tick, ticks_in_cycle, ticks_total, is_day)
