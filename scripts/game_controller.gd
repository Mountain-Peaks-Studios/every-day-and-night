extends Node2D

# Constants related to day/night cyckle
const TICKS_IN_CYCLE = 60
const HALF_CYCLE = TICKS_IN_CYCLE / 2

# Private variables related to day/night cycle
var current_tick = 0
var ticks_total = 0
var is_day = true

# Children
@onready var player = $Player
@onready var hud = $HUD
@onready var player_spawn: Vector2 = $PlayerSpawn.position


# Called when the node enters the scene tree.
func _ready():
	pass


# Update every frame
func _process(delta):
	if Input.is_action_just_pressed("temporary_action"):
		time_tick()


# Move time forward by one tick
func time_tick():
	current_tick = (current_tick + 1) % (TICKS_IN_CYCLE + 1)
	ticks_total += 1
	
	is_day = current_tick < HALF_CYCLE

	# Modify UI
	hud.on_clock_tick_UI(current_tick, TICKS_IN_CYCLE, ticks_total, is_day)


# Performed after player dies and emits the signal
func _on_player_dead():
	get_tree().paused = true
	hud.on_death_UI()
