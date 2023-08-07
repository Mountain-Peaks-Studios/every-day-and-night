extends CanvasLayer

const MIN_HEALTH: int = 2

var max_health: int = 10

@onready var player: GameCharacter = get_parent().get_node("Player")
@onready var health_bar: TextureProgressBar = $HealthBar

func _ready() -> void:
	max_health = player.health # TO CHANGE
	_update_health_bar(10)


func _update_health_bar(new_value: int) -> void:
	health_bar.value = 10
	var tween: Tween = create_tween()
	tween.tween_property(health_bar, "value", new_value, 0.5)


func _on_player_health_changed(new_hp: int) -> void:
	var new_health: int = int((10 - MIN_HEALTH) * float(new_hp) / max_health) + MIN_HEALTH
	_update_health_bar(new_health)
