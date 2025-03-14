class_name Player
extends RigidBody2D

@export var max_speed: float = 150.0

@export var sprite: Sprite2D
@export var weapon: WeaponHandler
@export var health: Health

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	state.linear_velocity = state.linear_velocity.limit_length(max_speed)

func _process(delta: float) -> void:
	sprite.rotation_degrees += 720.0 * delta
	
	if Input.is_action_just_pressed("shoot"):
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
	health.hurt(damage)
	MainCam.flash(Color(1, 0, 0, 0.4), 1.0)
