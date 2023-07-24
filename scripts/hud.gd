extends CanvasLayer

#children
@onready var clock_hand = $ClockHand
@onready var tick_label = $Tick
@onready var total_tick_label = $TotalTick
@onready var day_night_label = $DayNight

func _ready():
	tick_label.text = "0"
	total_tick_label.text = "0"
	day_night_label.text = "day"

# modify HUD when clock ticks
func on_clock_tick(tick, cycle_ticks, total_tick, is_day):
	clock_hand.rotation = (-PI/2) + ((tick * PI)/cycle_ticks) # rotate the hand
	
	# modify labels
	tick_label.text = str(tick)
	total_tick_label.text = str(total_tick)
	if is_day:
		day_night_label.text = "day"
	else:
		day_night_label.text = "night"
