extends BaseMob

var day_speed = 250
var day_is_night = 0

func _ready() -> void:
	self.speed = day_speed
	self.is_night = day_is_night
