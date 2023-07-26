extends CharacterBody2D


# Public variables visible in the editor
@export var speed: float = 50
@export var max_health: int = 30
@export var attack_cooldown: float = 2.0
@export var detection_radius: float = 300


# Private variables
var target: Node2D = null
var attack_timer: float = 0.0
var current_health: int = 0


# Called when the node enters the scene tree.
func _ready():
	current_health = max_health
	pass


# Update every frame
func _physics_process(delta):
	update_target()
	move_towards_target()
	#handle_attack(delta)
	update_health()


# Find the player, set it as the target
func update_target():
	target = get_parent().get_node("Player")


# Move to the chosen target
func move_towards_target():
	if target:
		# Calculate the direction of target
		var direction = target.global_position - global_position
		direction = direction.normalized()

		# Move to the target
		velocity = direction * speed 
		move_and_slide()


func update_health():
	var healthbar = $HealthBar
	healthbar.value = current_health


# Method for receiving damage
func _on_hurtbox_area_entered(hitbox):
	receive_damage(hitbox.damage)
	print(hitbox.get_parent().name + "'s hitbox touched " + name + "'s hurtbox and dealt " + str(hitbox.damage))


# Method for additional damage calculations
func receive_damage(base_damage: int):
	var actual_damage = base_damage
	
	current_health -= actual_damage

