extends Node2D

# direção e velocidade do inimigo
var direction = Vector2(-1,0)

func _ready() -> void:
	var animation = $enemy/AnimatedSprite2D
	add_to_group("enemy")
	animation.play("default")

func _process(delta: float) -> void:
	position += direction * Global.enemyVelocity * delta
	var animation = $enemy/AnimatedSprite2D
	
	if Global.feijaoativado == true:
		animation.play("paralisado")
		await get_tree().create_timer(2).timeout
		animation.play("default")
	else:
		animation.play("default")
	
	if position.x < -150:
		queue_free()

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.name == "bullet":
		var random = RandomNumberGenerator.new()
		var chance = random.randi_range(1,100)
		if chance <= 10:
			print("Powerup gerado")
			Global.bean += 1
		Global.score += 1
		print("Pontuação: ", Global.score)
		queue_free()

	if area.name == "wall":
		if Global.score > Global.best_score:
			Global.best = true
			Global.best_score = Global.score
			Global.bean = 0
			var file = FileAccess.open("user://savegame.save", FileAccess.WRITE)
			if file:
				file.store_line(str(Global.best_score))  # Salva o score como texto
				file.close()
			print("Novo melhor score salvo:", Global.best_score)
		var cursor = load("res://sprites/cursor.png")
		Input.set_custom_mouse_cursor(cursor)
		get_tree().change_scene_to_file("res://cenas/gameOver.tscn")
