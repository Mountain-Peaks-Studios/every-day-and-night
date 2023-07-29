extends BaseMob

var night_speed = 100
var night_isNight = 1

func _ready():
	self.speed = night_speed
	self.isNight = night_isNight

func _physics_process(delta):
	update_target()
	update_health()
	move_towards_target()
