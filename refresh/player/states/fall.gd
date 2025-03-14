extends PlayerState

@export var move_speed: float = 700.0

func physics_update(_delta: float) -> void:
	player.apply_central_force(
		Vector2.RIGHT * player.get_input_axis() * move_speed
	)


func _on_weapon_handler_fired() -> void:
	pass
