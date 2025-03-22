class_name Player
extends RigidBody2D

@export var max_speed: float = 150.0
@export var max_shots: int = 20

@export var sprite: HeightSprite
@export var weapon: WeaponHandler
@export var health: Health

var shots: int = 20

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	state.linear_velocity = state.linear_velocity.limit_length(max_speed)

func _process(delta: float) -> void:
	#sprite.rotation_degrees += 720.0 * delta
	
	if Input.is_action_just_pressed("shoot") and shots > 0:
		weapon.firing = true
	elif Input.is_action_just_released("shoot"):
		weapon.firing = false

func get_input_axis() -> float:
	return Input.get_axis("move_left", "move_right")


func _on_weapon_handler_recoiled(recoil: Vector2) -> void:
	linear_velocity.y = min(linear_velocity.y, 0)
	apply_central_impulse(
		recoil
	)


func _on_hurtbox_knocked_back(knockback: Vector2) -> void:
	apply_central_impulse(
		knockback
	)


func _on_hurtbox_hurt(hitbox: Hitbox, damage: int, invinc_time: float) -> void:
	sprite.play_hurt()
	health.hurt(damage)
	MainCam.flash(Color(1, 0, 0, 0.4), 1.0)


func _on_hitbox_hit(hurtbox: Hurtbox) -> void:
	shots = max_shots
	apply_central_impulse(
		Vector2.UP * max_speed
	)


func _on_weapon_handler_fired() -> void:
	sprite.squish(2.5, true, 0.75)
	shots -= 1
	if shots <= 0:
		shots = 0
		weapon.firing = false
