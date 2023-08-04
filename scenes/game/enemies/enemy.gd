class_name Enemy
extends GameCharacter

const SPEED = 30
@export var player: GameCharacter
@onready var nav_agent: NavigationAgent2D = $EnemyNavigationAgent2D 

func _physics_process(delta: float) -> void:
	var dir = to_local(nav_agent.get_next_path_position()).normalized()
	velocity = dir * SPEED
	move_and_slide()

func make_path() -> void:
	nav_agent.target_position = player.global_position

func _on_timer_timeout():
	make_path()
