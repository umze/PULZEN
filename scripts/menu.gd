extends Node2D

func _ready() -> void:
	var viewport = get_viewport_rect().size
	
	var fundo = $Degrade
	var fundoTexture = fundo.texture.get_size()
	fundo.scale = viewport / fundoTexture * 3
	fundo.position = Vector2(0,0)
	fundo.z_index = -10
	
	var zumbi = $Zumbizumbi
	zumbi.position = Vector2(viewport.x - 200, viewport.y - 300)
	zumbi.scale = Vector2(15,15)

	var player = $Jogado
	player.position = Vector2(+300, viewport.y - 300)
	player.scale = Vector2(15,15)
	
	var play = $play
	play.position = Vector2(viewport.x / 2 - 140, viewport.y / 2)

	var dontPlay = $dontPlay
	dontPlay.position = Vector2(viewport.x / 2 - 140, viewport.y / 2 + 100)
	
	var logo = $Logo
	logo.position = Vector2(viewport.x / 2, viewport.y / 2 - 100)

func _on_play_pressed() -> void:
	var viewport = get_viewport().size
	var tween = get_tree().create_tween()

	tween.parallel().tween_property($Degrade, "position", Vector2(0, viewport.y * 2), 1.5) \
		.set_trans(Tween.TRANS_SINE) \
		.set_ease(Tween.EASE_IN_OUT)

	tween.parallel().tween_property($Zumbizumbi, "position", Vector2($Zumbizumbi.position.x, viewport.y * 2), 1) \
		.set_trans(Tween.TRANS_SINE) \
		.set_ease(Tween.EASE_IN_OUT)

	tween.parallel().tween_property($Jogado, "position", Vector2(135.0, viewport.y * 2), 1) \
		.set_trans(Tween.TRANS_SINE) \
		.set_ease(Tween.EASE_IN_OUT)

	tween.parallel().tween_property($play, "position", Vector2($play.position.x, viewport.y * 2), 1) \
		.set_trans(Tween.TRANS_SINE) \
		.set_ease(Tween.EASE_IN_OUT)
		
	tween.parallel().tween_property($dontPlay, "position", Vector2($dontPlay.position.x, viewport.y * 2.5), 1) \
		.set_trans(Tween.TRANS_SINE) \
		.set_ease(Tween.EASE_IN_OUT)
		
	tween.parallel().tween_property($Logo, "position", Vector2($Logo.position.x, -(viewport.y * 2)), 1) \
		.set_trans(Tween.TRANS_SINE) \
		.set_ease(Tween.EASE_IN_OUT)
		
	var parede = $parede
	parede.z_index = -12
	tween.parallel().tween_property(parede, "position", Vector2(240, parede.position.y), 1) \
		.set_trans(Tween.TRANS_SINE) \
		.set_ease(Tween.EASE_IN_OUT)
	
	var player = $Player
	player.z_index = -12
	tween.parallel().tween_property(player, "position", Vector2(135, player.position.y), 1) \
		.set_trans(Tween.TRANS_SINE) \
		.set_ease(Tween.EASE_IN_OUT)
	
	var cursor = load("res://sprites/crosshair.png")
	Input.set_custom_mouse_cursor(cursor)
	await get_tree().create_timer(1.5).timeout
	get_tree().change_scene_to_file("res://cenas/jogo.tscn")

func _on_dont_play_pressed() -> void:
	var viewport = get_viewport().size
	var tween = get_tree().create_tween()

	tween.parallel().tween_property($Degrade, "position", Vector2(0, viewport.y * 2), 1.5) \
		.set_trans(Tween.TRANS_SINE) \
		.set_ease(Tween.EASE_IN_OUT)

	tween.parallel().tween_property($Zumbizumbi, "position", Vector2($Zumbizumbi.position.x, viewport.y * 2), 1) \
		.set_trans(Tween.TRANS_SINE) \
		.set_ease(Tween.EASE_IN_OUT)

	tween.parallel().tween_property($Jogado, "position", Vector2(135.0, viewport.y * 2), 1) \
		.set_trans(Tween.TRANS_SINE) \
		.set_ease(Tween.EASE_IN_OUT)

	tween.parallel().tween_property($play, "position", Vector2($play.position.x, viewport.y * 2), 1) \
		.set_trans(Tween.TRANS_SINE) \
		.set_ease(Tween.EASE_IN_OUT)
		
	tween.parallel().tween_property($dontPlay, "position", Vector2($dontPlay.position.x, viewport.y * 2.5), 1) \
		.set_trans(Tween.TRANS_SINE) \
		.set_ease(Tween.EASE_IN_OUT)
		
	tween.parallel().tween_property($Logo, "position", Vector2($Logo.position.x, -(viewport.y * 2)), 1) \
		.set_trans(Tween.TRANS_SINE) \
		.set_ease(Tween.EASE_IN_OUT)
	
	Input.set_custom_mouse_cursor(null)
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

	await get_tree().create_timer(1.5).timeout
	get_tree().quit()
