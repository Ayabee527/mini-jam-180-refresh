class_name EnemyFloater
extends RigidBody2D



func _on_hurtbox_hurt(hitbox: Hitbox, damage: int, invinc_time: float) -> void:
	pass # Replace with function body.

func _on_hurtbox_knocked_back(knockback: Vector2) -> void:
	apply_central_impulse(
		knockback
	)
