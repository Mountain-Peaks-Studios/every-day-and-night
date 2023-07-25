# This script represents a character body with shooting and health mechanics.

# Extends the CharacterBody2D class.
extends CharacterBody2D

## Public variables that can be edited in the editor.
# TODO: The InputMap action for shooting must be set up in the project settings.
@export var speed: float = 200
@export var bulletScene: PackedScene
@export var bulletsLayer: int = 1
@export var shootCooldown: float = 0.2
@export var maxHealth: int = 100
@export var invincibilityTime: float = 2.0

# dash-related public variables
@export var dashSpeed: float = 500  # Speed of the dash movement
@export var dashDuration: float = 1.0  # Duration of the dash in seconds
@export var dashCooldown: float = 1.0  # Cooldown between dashes in second; must be set up in dash_timer anyways!

## Private variables to handle movement, shooting, health, and invincibility.
var customVelocity: Vector2 = Vector2.ZERO
var canShoot: bool = true
var currentHealth: int = maxHealth
var invincible: bool = false
var invincibilityTimer: float = 0.0

# dash-related private variables
var canDash: bool = true
var isDashing: bool = false
var dashTimer: float = 0.0
var dashDirection: Vector2 = Vector2.ZERO

# Called when the node enters the scene tree.
func _ready():
	# Enable physics processing.
	set_physics_process(true)
	# Initialize the character's health to its maximum value.
	currentHealth = maxHealth

func _physics_process(delta: float) -> void:
	# Handle player input, shooting, dashing, and invincibility.
	handleInput()
	handleShooting(delta)
	handleDash(delta)
	handleInvincibility(delta)
	update_health()
	# Move the character using Godot's built-in move_and_slide function.
	move_and_slide()

# Handles player input to set the character's velocity.
func handleInput() -> void:
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
	velocity = velocity.normalized() * speed

# Handles dashing mechanic, restricting the dash rate with cooldown.
func handleDash(delta: float) -> void:
	# Check if dashing is allowed and the "dash" action is pressed.
	if canDash and Input.is_action_pressed("dash") and not isDashing:
		# Get the dash direction based on player input.
		dashDirection = Vector2.ZERO
		if Input.is_action_pressed("ui_right"):
			dashDirection.x += 1
		if Input.is_action_pressed("ui_left"):
			dashDirection.x -= 1
		if Input.is_action_pressed("ui_down"):
			dashDirection.y += 1
		if Input.is_action_pressed("ui_up"):
			dashDirection.y -= 1

		# Normalize the dash direction and multiply it by the dash speed to control dash movement speed.
		if dashDirection != Vector2.ZERO:
			dashDirection = dashDirection.normalized() * dashSpeed

		# Start dashing if the dash direction is valid.
		if dashDirection != Vector2.ZERO:
			isDashing = true
			canDash = false
			dashTimer = dashDuration

	# Handle ongoing dash movement.
	if isDashing:
		# Reduce the dash timer.
		dashTimer -= delta

		if dashTimer <= 0:
			# End the dash after the dash duration has passed.
			isDashing = false
			velocity = Vector2.ZERO  # Reset velocity to stop the dash.

			# Start the dash cooldown.
			$dash_timer.start(dashCooldown)

# Timer callback to reset the canDash variable after the cooldown has passed.
func _on_dash_timer_timeout() -> void:
	canDash = true

# Handles shooting mechanic, restricting the shooting rate with cooldown.
func handleShooting(delta: float) -> void:
	# Check if shooting is allowed and the "shoot" action is pressed.
	if canShoot and Input.is_action_pressed("shoot"):
		# Call the shoot function and start the shooting cooldown.
		shoot()
		canShoot = false
		$shoot_timer.start(shootCooldown)

# Timer callback to reset the canShoot variable after the cooldown has passed.
func _on_shoot_timer_timeout() -> void:
	canShoot = true

# Shoots a bullet instance from the character.
func shoot() -> void:
	if bulletScene:
		var bulletInstance = bulletScene.instance()
		bulletInstance.position = position
		bulletInstance.rotation = rotation
		bulletInstance.set("owner", self)
		get_parent().add_child(bulletInstance)

# Reduces the character's health when taking damage.
func takeDamage(damage: int) -> void:
	# Check if the character is invincible and return if it is.
	if invincible:
		return

	# Reduce the current health by the damage amount.
	currentHealth -= damage

	# Check if the character's health has dropped to or below zero, call the die function if true.
	if currentHealth <= 0:
		die()

	# Activate invincibility and set the invincibility timer.
	invincible = true
	invincibilityTimer = invincibilityTime

# Handles the invincibility mechanic, disabling it after a certain time.
func handleInvincibility(delta: float) -> void:
	if invincible:
		# Reduce the invincibility timer.
		invincibilityTimer -= delta
		# Disable invincibility if the timer reaches or goes below zero.
		if invincibilityTimer <= 0:
			invincible = false

func update_health():
	var healthbar = $healthbar
	healthbar.value = currentHealth
	
	

# Handles the character's death logic.
func die() -> void:
	# TODO: Implement the end game logic here.
	pass