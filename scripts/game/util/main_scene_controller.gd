extends Node2D

# Constants related to day/night cyckle
const TICKS_IN_CYCLE = 60
const HALF_CYCLE = TICKS_IN_CYCLE / 2

# Private variables related to day/night cycle
var current_tick = 0
var ticks_total = 0
var is_day = true

# Private variables related to levelling up
var ticks_to_level: int = 60 # PLACEHOLDER VALUE
var level: int = 0

# Children
@onready var player: Node = $Player
@onready var hud: Node = $HUD
@onready var player_spawn: Vector2 = $PlayerSpawn.position

# Called when the node enters the scene tree.
func _ready() -> void:
	level = 1


# Update every frame
func _process(delta: float) -> void:
	# Level up once current_tick (EXP) exceeds tick_to_level (EXP needed to level up)
	if ticks_total >= ticks_to_level:
		handle_level_up()
	
	# PLACEHOLDER: time_tick on 't'
	if Input.is_action_just_pressed("temporary_action") and not get_tree().paused:
		time_tick()


# Move time forward by one tick
func time_tick() -> void:
	# Increase ticks_total (only if current_tick isn't 60)
	if current_tick < 60:
		ticks_total += 1
	# Calculate current_tick
	current_tick = (current_tick + 1) % (TICKS_IN_CYCLE + 1)
	
	# Check whether it's day or night
	is_day = current_tick < HALF_CYCLE
	
	# Modify UI
	hud.on_clock_tick_UI(current_tick, TICKS_IN_CYCLE, ticks_total, is_day)
	
	# Chage player sprite/animation
	player.animation_check(is_day)


# Performed after player dies and emits the signal
func _on_player_dead() -> void:
	get_tree().paused = true
	hud.on_death_UI()


# Handles levelling up
func handle_level_up() -> void:
	# Increase the level and make next level more difficult to reach
	level += 1
	ticks_to_level += 30 + 30 * level # TODO: balace the values
	
	# Show level up popup (and modify the placeholder value HUD)
	get_tree().paused = true
	hud.on_level_up(level, ticks_to_level) 
