extends BaseMob

var night_speed = 100
var night_is_night = 1

func _ready() -> void:
	self.speed = night_speed
	self.is_night = night_is_night
