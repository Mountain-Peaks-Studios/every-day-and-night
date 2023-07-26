extends CanvasLayer

# Children
@onready var clock_hand = $ClockHand
@onready var tick_label = $Tick
@onready var total_tick_label = $TotalTick
@onready var day_night_label = $DayNight
@onready var death_panel = $DeathPanel

# Called when the node enters the scene tree.
func _ready():
	# Initialize HUD labels
	tick_label.text = "0"
	total_tick_label.text = "0"
	day_night_label.text = "day"
	
	death_panel.hide()


# Update HUD when the clock ticks; triggered from the main script.
func on_clock_tick_UI(tick, cycle_ticks, total_tick, is_day):
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

func on_death_UI():
	death_panel.show()
