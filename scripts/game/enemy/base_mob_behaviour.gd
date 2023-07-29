class_name BaseMob extends CharacterBody2D

# Public variables visible in the editor
@export var speed: float = 100.0
@export var max_health: int = 30
@export var attack_cooldown: float = 2.0
@export var detection_radius: float = 50.0
@export var is_night: bool = 0 # Day mob 0, night mob 1

# Private variables
var target: Node2D = null
var attack_timer: float = 0.0
var current_health: int = 0


# Called when the node enters the scene tree.
func _ready() -> void:
	current_health = max_health


# Update every frame
func _physics_process(delta: float) -> void:
	update_target()
	update_healthbar()
	move_towards_target()


# Find the player, set it as the target
func update_target() -> void:
	target = get_parent().get_node("Player")


# Move to the chosen target
func move_towards_target() -> void:
	if target:
		# Calculate the direction of target
		var direction = target.global_position - global_position
		direction = direction.normalized()
		
		# Move to the target
		velocity = direction * speed 
		move_and_slide()


# Update the healthbar's value
func update_healthbar() -> void:
	var healthbar = $HealthBar
	healthbar.value = current_health


# Method for receiving damage
func _on_hurtbox_area_entered(hitbox: Node) -> void:
	receive_damage(hitbox.damage)
	print(hitbox.get_parent().name + "'s hitbox touched " + name + "'s hurtbox and dealt " + str(hitbox.damage))
	
	if hitbox.is_in_group("player_projectile"):
		hitbox.destroy()

# Method for additional damage calculations
func receive_damage(base_damage: int) -> void:
	var actual_damage = base_damage
	
	current_health -= actual_damage
	
	if current_health <= 0:
		death()

# Remove from scene on death
func death() -> void:
	queue_free()
