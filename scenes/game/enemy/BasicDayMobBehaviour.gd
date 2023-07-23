extends CharacterBody2D

# Public variables visible in the editor
@export var speed: float = 100
@export var damage: int = 20
@export var attackCooldown: float = 2.0
@export var detectionRadius: float = 300

# Private varaibles
var target: Node2D = null
var attackTimer: float = 0.0

# Initialising the Mob
func _ready():
	pass

# Update behaviour every frame
func _physics_process(delta: float) -> void:
	update_target()
	move_towards_target()
	handle_attack(delta)

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

func handle_attack(delta: float) -> void:
	if target:
		# Calculate distance to the target to check if in-range
		var distanceToTarget = global_position.distance_to(target.global_position)
		
		# Check if target is within detectionRadius
		if distanceToTarget < detectionRadius:
			# Reduce attack cooldown timer
			attackTimer =- delta
			
			# If the attack cooldown is over, perform the attack, reset the timer
			if attackTimer <= 0.0:
					handle_attack_helper()
					attackTimer = attackCooldown

func handle_attack_helper() -> void:
	# Send a damage signal to the target if chosen. 
	# Replace "damage" with the signal name for taking damage in player script
	if target:
		target.emit_signal("take_damage", damage)
