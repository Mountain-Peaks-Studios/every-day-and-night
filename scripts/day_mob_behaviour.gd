extends CharacterBody2D

# Public variables visible in the editor
@export var speed: float = 100
@export var damage: int = 20
@export var attack_cooldown: float = 2.0
@export var detection_radius: float = 300

# Private variables
var target: Node2D = null
var attack_timer: float = 0.0
signal deal_damage


# Called when the node enters the scene tree.
func _ready():
	pass


# Update every frame
func _physics_process(delta):
	update_target()
	move_towards_target()
	#handle_attack(delta)


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


#func handle_attack(delta):
#	if target:
#		# Calculate distance to the target to check if in-range
#		var distance_to_target = global_position.distance_to(target.global_position)
#
#		# Check if target is within detectionRadius
#		if distance_to_target < detection_radius:
#			# Reduce attack cooldown timer
#			attack_timer =- delta
#
#			# If the attack cooldown is over, perform the attack, reset the timer
#			if attack_timer <= 0.0:
#					handle_attack_helper()
#					attack_timer = attack_cooldown
#
#
#func handle_attack_helper():
#	# Send a damage signal to the target if chosen. 
#	# Replace "damage" with the signal name for taking damage in player script
#	if target:
#		target.emit_signal("deal_damage", damage)

