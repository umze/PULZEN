extends Node2D

# direção e velocidade da bala
var direction = Vector2(1,0)
var velocity = 1000

# ir pro final da tela e se destruir
func _process(delta: float) -> void:
	position += direction * velocity * delta
	var viewport = get_viewport().size
	
	if position.x > viewport.x:
		queue_free()


func _on_bullet_area_entered(area: Area2D) -> void:
	if area.name == "enemy":
		queue_free()
