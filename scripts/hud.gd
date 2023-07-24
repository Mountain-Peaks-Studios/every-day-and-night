extends CanvasLayer

# Reference to child nodes
# These variables store references to child nodes for easy access.
@onready var clock_hand = $ClockHand
@onready var tick_label = $Tick
@onready var total_tick_label = $TotalTick
@onready var day_night_label = $DayNight

func _ready():
	# Initialize HUD labels
	tick_label.text = "0"
	total_tick_label.text = "0"
	day_night_label.text = "day"

# Update HUD when the clock ticks
# This function is called whenever the time_tick() function is triggered from the main script.
# It updates the visuals and labels based on the current tick values and day/night status.
func on_clock_tick(tick, cycle_ticks, total_tick, is_day):
	# Rotate the clock hand based on the current tick
	# The clock hand is rotated to indicate the current time visually.
	clock_hand.rotation = (-PI/2) + (tick * PI / cycle_ticks)
	
	# Update tick and total tick labels
	# These labels display the current tick and the total number of ticks since the game started.
	tick_label.text = str(tick)
	total_tick_label.text = str(total_tick)
	
	# Update the day/night label
	# The label displays whether it's currently day or night based on the "is_day" boolean.
	if is_day:
		day_night_label.text = "day"
	else:
		day_night_label.text = "night"
