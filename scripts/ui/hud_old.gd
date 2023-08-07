extends CanvasLayer

# Children
@onready var clock_hand: TextureRect = $ClockHand
@onready var tick_label: Label = $Tick
@onready var total_tick_label: Label = $TotalTick
@onready var day_night_label: Label = $DayNight
@onready var death_panel: Panel = $DeathPanel
@onready var level_label: Label = $Level
@onready var ticks_needed_label: Label = $TicksNeeded
@onready var level_up_panel: Panel = $LevelUpPanel
@onready var run_label: Label = $Run


# Called when the node enters the scene tree.
func _ready() -> void:
	# Initialize HUD labels
	tick_label.text = "0"
	total_tick_label.text = "0"
	day_night_label.text = "day"
	run_label.text = str(VariablesToKeep.run_number)
	
	death_panel.hide()
	# Hide the level up popup
	level_up_panel.hide()


# Update HUD when the clock ticks; triggered from the main script.
func on_clock_tick_UI(tick, cycle_ticks, total_tick, is_day) -> void:
	# Rotate the clock hand based on the current tick
	clock_hand.rotation = (-PI/2) + (tick * PI / cycle_ticks)
	
	# Update tick and total tick HUD labels
	tick_label.text = str(tick)
	total_tick_label.text = str(total_tick)
	
	# Update the day/night HUD label; based on the "is_day" boolean.
	if is_day:
		day_night_label.text = "day"
	else:
		day_night_label.text = "night"

# Show gameover/death UI after player's death
func on_death_UI() -> void:
	death_panel.show()

func on_level_up(level: int, ticks_needed: int) -> void:
	# Update labels
	level_label.text = str(level)
	ticks_needed_label.text = str(ticks_needed)
	level_up_panel.show()


func _on_button_pressed() -> void:
	level_up_panel.hide()
	get_tree().paused = false
