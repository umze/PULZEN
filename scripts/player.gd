extends Node2D

# mover o jogador verticalmente com o mouse
func _process(delta: float) -> void:
	var mousePos = get_viewport().get_mouse_position()
	position.y = mousePos.y + 10
