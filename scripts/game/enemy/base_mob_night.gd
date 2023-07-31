extends BaseMob

var night_speed = 100
var night_is_night = 1

func _ready() -> void:
	current_health = max_health
	self.speed = night_speed
	self.is_night = night_is_night
