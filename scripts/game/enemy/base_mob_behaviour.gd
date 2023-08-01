class_name BaseMob extends CharacterBody2D

# Public variables visible in the editor
@export var speed: float = 100.0
@export var max_health: int = 30
@export var attack_cooldown: float = 2.0
@export var detection_radius: float = 50.0
@export var min_distance: float = 45.0 # Define a minimum distance to stop approaching the target
@export var is_night: bool = 0 # Day mob 0, night mob 1
@export var coin_amount: int = 1
@export var coin_drop_chance: float = 0.20 # Given in decimal

# Private variables
var target: Node2D = null
var attack_timer: float = 0.0
var current_health: int = 0

# Packed scenes
@onready var coin: PackedScene = preload("res://scenes/game/item/coin.tscn")


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
		# Calculate the direction and distance to the target
		var direction = target.global_position - global_position
		var distance_to_target = direction.length()
		
		if distance_to_target > min_distance:
			# Move to the target
			direction = direction.normalized()
			velocity = direction * speed 
			move_and_slide()
		else:
			# Stop moving
			velocity = Vector2(0, 0)


# Update the healthbar's value
func update_healthbar() -> void:
	var healthbar = $HealthBar
	healthbar.value = current_health


# Method for receiving damage
func _on_hurtbox_area_entered(hitbox: Node) -> void:
	if hitbox.name == "Merchant":
		pass
	else:
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


func calculate_if_coin_dropped(chance: float) -> void:
	var random_number = randf_range(0, 1)
	if random_number <= chance:
		drop_coin(coin_amount)
		print("Debug: coin dropped")


func drop_coin(amount: int) -> void:
	var temp_coin = coin.instantiate()
	self.get_parent().add_child(temp_coin)
	temp_coin.position = self.position
	temp_coin.amount = amount


# Remove from scene on death
func death() -> void:
	calculate_if_coin_dropped(coin_drop_chance)
	queue_free()
