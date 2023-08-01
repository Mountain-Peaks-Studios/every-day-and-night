extends CharacterBody2D

# Signals
signal dead

# Public variable related to movement, shooting, health, invincibility, and money
@export var bullet_scene: PackedScene
@export var bullet_layer: int = 1 # Not used
@export var shoot_cooldown: float = 0.2
@export var melee_cooldown: float = 1
@export var invincibility_time: float = 2.0
@export var base_projectile : PackedScene
@export var coins_amount: int = 0

# Private variable related to movement, basic attack, health, and invincibility.
var custom_velocity: Vector2 = Vector2.ZERO # Not used
var can_attack: bool = true
var current_health: int = VariablesToKeep.player_max_health
var invincible: bool = false
var invincibility_timer: float = 0.0

# Public variables related to dash action
@export var dash_speed: float = 350  # Speed of the dash movement
@export var dash_duration: float = 1.0  # Duration of the dash in seconds
@export var dash_cooldown: float = 1.0  # Cooldown between dashes in second; must be set up in dash_timer anyways!

# Private variables related to dash action
var can_dash: bool = true
var is_dashing: bool = false
var dash_timer: float = 0.0
var dash_direction: Vector2 = Vector2.ZERO

# Private variables related to the inventory
var inventory_resource: Resource = load("res://items/inventory.gd")
var inventory: Resource = inventory_resource.new()

# Children
@onready var hurtbox = $PlayerHurtbox
@onready var projectile_scene: PackedScene = preload("res://scenes/game/projectile/player_projectile.tscn")
@onready var shoot_timer = $ShootTimer
@onready var melee_timer = $MeleeTimer
@onready var animation = $PlayerAnimation


# Called when the node enters the scene tree.
func _ready() -> void:
	# Enable physics processing.
	set_physics_process(true)
	
	# Initialize the character's health to its maximum value.
	current_health = VariablesToKeep.player_max_health
	
	if get_parent().is_day:
		animation.get_node("AnimationTree").get_node("AnimationPlayer").play("PlayerAnim/player_idle_sword")
	else:
		animation.get_node("AnimationTree").get_node("AnimationPlayer").play("PlayerAnim/player_idle_gun")



# Update every frame
func _physics_process(delta: float) -> void:
	# Make the player follow the cursor direction
	follow_cursor()
	
	# Handle player input, dashing, health and invincibility.
	handle_input()
	handle_dash(delta)
	handle_invincibility(delta)
	update_health()
	
	# Check if attack is allowed and the "shoot" action is pressed.
	if can_attack and Input.is_action_just_pressed("attack"):
		if get_parent().is_day:
			handle_melee(delta)
		else:
			handle_shooting(delta)
	
	# Move the character using Godot's built-in move_and_slide function.
	move_and_slide()
	
	# DEBUG: adding and removing item
	if Input.is_action_just_pressed("temp_add_potion"):
		inventory.add_item("Health Potion", 3)
		print(inventory._items)
	elif Input.is_action_just_pressed("temp_remove_potion"):
		inventory.remove_item("Health Potion", 1)
		print(inventory._items)

# Chooses animation based on the time of day
func animation_check(is_day) -> void:
	if is_day: 
		animation.get_node("AnimationTree").get_node("AnimationPlayer").play("PlayerAnim/player_idle_sword")
	else:
		animation.get_node("AnimationTree").get_node("AnimationPlayer").play("PlayerAnim/player_idle_gun")

# Handles the player following the direction of the mouse cursor
func follow_cursor() -> void:
	if get_global_mouse_position().x >= position.x:
		# Left
		$PlayerAnimation.scale = Vector2(-0.08,0.08)
	else:
		# Right
		$PlayerAnimation.scale = Vector2(0.08,0.08)


# Handles player input to set the character's velocity.
func handle_input() -> void:
	# Reset the velocity to zero.
	velocity = Vector2.ZERO

	# Check for input actions and modify the velocity accordingly.
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1

	# Normalize the velocity and multiply it by the speed to control movement speed.
	velocity = velocity.normalized() * VariablesToKeep.player_speed


# Handles dashing mechanic, restricting the dash rate with cooldown.
func handle_dash(delta: float) -> void:
	# Check if dashing is allowed and the "dash" action is pressed.
	if can_dash and Input.is_action_just_pressed("dash") and not is_dashing:
		# Get the dash direction based on player input.
		dash_direction = Vector2.ZERO
		if Input.is_action_pressed("ui_right"):
			dash_direction.x += 1
		if Input.is_action_pressed("ui_left"):
			dash_direction.x -= 1
		if Input.is_action_pressed("ui_down"):
			dash_direction.y += 1
		if Input.is_action_pressed("ui_up"):
			dash_direction.y -= 1

		# Normalize the dash direction and multiply it by the dash speed to control dash movement speed.
		if dash_direction != Vector2.ZERO:
			dash_direction = dash_direction.normalized() * dash_speed

		# Start dashing if the dash direction is valid.
		if dash_direction != Vector2.ZERO:
			is_dashing = true
			can_dash = false
			dash_timer = dash_duration

	# Handle ongoing dash movement.
	if is_dashing:
		velocity = dash_direction
		# Reduce the dash timer.
		dash_timer -= delta
		
		# Start the dash cooldown.
		$DashTimer.start(dash_cooldown)
		
		if dash_timer <= 0:
			# End the dash after the dash duration has passed.
			is_dashing = false
			velocity = Vector2.ZERO  # Reset velocity to stop the dash.


# Timer callback to reset the can_dash variable after the cooldown has passed.
func _on_dash_timer_timeout() -> void:
	can_dash = true


# Handles shooting mechanic, restricting the shooting rate with cooldown.
func handle_shooting(delta: float) -> void:
	# Call the shoot function and start the shooting cooldown.
	shoot()
	can_attack = false
	shoot_timer.start(shoot_cooldown)


# Handles basic melee attack
func handle_melee(delta: float) -> void:
	melee()
	can_attack = false
	melee_timer.start(melee_cooldown)
	


# Timer callback to reset the canShoot variable after the cooldown has passed.
func _on_shoot_timer_timeout() -> void:
	can_attack = true
	# Placeholder
	if get_parent().is_day:
		animation.get_node("AnimationTree").get_node("AnimationPlayer").play("PlayerAnim/player_idle_sword")
	else:
		animation.get_node("AnimationTree").get_node("AnimationPlayer").play("PlayerAnim/player_idle_gun")


# Shoots a bullet instance from the character.
func shoot() -> void:
	# Placeholder
	animation.get_node("AnimationTree").get_node("AnimationPlayer").play("PlayerAnim/player_idle_gun")
	if projectile_scene:
		var projectile = projectile_scene.instantiate()
		self.get_parent().add_child(projectile)
		projectile.global_position = self.global_position
		
		# This must be changed to rotation of the player
		var projectile_rotation = self.global_position.direction_to(get_global_mouse_position()).angle()
		projectile.rotation = projectile_rotation


func melee() -> void:
	# Placeholder
	animation.get_node("AnimationTree").get_node("AnimationPlayer").play("PlayerAnim/player_attack_sword")
	pass


# Function to handle enemy attacks (triggered by the "take_damage" signal).
func _on_enemy_attack(damage: int) -> void:
	# Check if the character is invincible and return if it is.
	if invincible:
		return

	# Reduce the current health by the damage amount.
	current_health -= damage

	# Check if the character's health has dropped to or below zero, call the die function if true.
	if current_health <= 0:
		die()

	# Activate invincibility and set the invincibility timer.
	invincible = true
	invincibility_timer = invincibility_time


# Handles the invincibility mechanic, disabling it after a certain time.
func handle_invincibility(delta: float) -> void:
	if invincible:
		# Reduce the invincibility timer.
		invincibility_timer -= delta
		# Disable invincibility if the timer reaches or goes below zero.
		if invincibility_timer <= 0:
			invincible = false


func update_health() -> void:
	var healthbar = $HealthBar
	healthbar.value = current_health


func add_coins(amount: int) -> void:
	coins_amount += amount
	print(coins_amount)


# Handles the character's death logic.
func die() -> void:
	dead.emit()
	

# Method for receiving damage
func _on_hurtbox_area_entered(hitbox: Node) -> void:
	receive_damage(hitbox.damage)
	print(hitbox.get_parent().name + "'s hitbox touched " + name + "'s hurtbox and dealt " + str(hitbox.damage))


# Method for additional damage calculations
func receive_damage(base_damage: int) -> void:
	var actual_damage = base_damage
	current_health -= actual_damage
