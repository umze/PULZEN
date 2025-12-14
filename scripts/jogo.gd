extends Node2D

# importa a bala
var bullet_scene = preload("res://cenas/bullet.tscn")

# importa o inimigo
var enemy_scene = preload("res://cenas/enemy.tscn")

# pontuação mínima padrão para aumentar a dificuldadde
var objective = 5

# quantidade para diminuir o tempo
var timeless = 0

var beanAtivado = false

var backupVelocityAMais = 0

# rodar no primeiro frame do jogo
func _ready() -> void:
	var viewport = get_window().size
	
	var jogadorvagabundo = $Player
	jogadorvagabundo.z_index = 10
	var ponto = $Text
	ponto.z_index = 11
	var bestpoint = $BestPoint
	bestpoint.z_index = 12
	
	# mostrar o texto na tela
	var scoreText = $Text
	scoreText.position.x = 25
	scoreText.position.y = 10
	# mostrar a melhor pontuação
	var bestText = $BestPoint
	bestText.position.x = 25
	bestText.position.y = 70
	var bestPoints = $BestPoint/RichTextLabel
	bestPoints.text = "melhor pontuação: " + str(Global.best_score)
	
	var beanIMG = $Bean
	beanIMG.z_index = 12
	beanIMG.position.x = 50
	beanIMG.position.y = viewport.y - 50
	var beanNumber = $beanNumber
	beanNumber.position.x = 50 - 33.5
	beanNumber.position.y = viewport.y - 50 - 33.5
	
# rodar a cada frame
func _process(delta: float) -> void:
	# atualizar a pontuação do jogador
	var scoreText = $Text/RichTextLabel
	scoreText.text = "Pontos: " + str(Global.score)
	
	var beanNumber = $beanNumber
	beanNumber.text = str(Global.bean) + " "
	
	# descer o cooldown da arma
	Global.cooldown -= delta

	var time = $Timer
	
	if Global.score == objective and timeless != 5:
		time.wait_time -= 0.3
		print("Tempo para spawn: ", time.wait_time)
		objective += 5
		print("Objetivo: ", objective)
		timeless += 1
	if Global.score == objective and timeless == 5:
		print("Velocidade do inimigo: ", Global.enemyVelocity)
		objective += 5
		print("Objetivo: ", objective)
		if beanAtivado == true:
			backupVelocityAMais += 50
		else:
			Global.enemyVelocity += 50

# atirar
func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("mouse_left") and Global.cooldown <= 0:
		var player = $Player
		var mousePos = get_viewport().get_mouse_position()
		player.position.y = mousePos.y + 10

		var animation = $Player/player/AnimatedSprite2D
		var bullet = bullet_scene.instantiate()
		bullet.position.x = player.position.x + 40
		bullet.position.y = player.position.y + 8
		get_parent().add_child(bullet)
		Global.cooldown = 0.3
		animation.play("tiro")
		await get_tree().create_timer(0.3).timeout
		animation.play("parado")
		
	if Input. is_action_just_pressed("bean") and Global.bean > 0 and beanAtivado == false:
		var peidoSFX = $peido
		peidoSFX.play()
		
		var peidoIMG = $peido2
		peidoIMG.position = Vector2($Player.position.x - 50, $Player.position.y + 50)
		peidoIMG.play("default")
		

		beanAtivado = true
		Global.bean -= 1
		
		
		var backupVelocity = Global.enemyVelocity
		Global.enemyVelocity = 0
		Global.feijaoativado = true
		await get_tree().create_timer(2).timeout
		Global.feijaoativado = false
		@warning_ignore("confusable_local_usage")
		Global.enemyVelocity = backupVelocity + backupVelocityAMais
		@warning_ignore("unused_variable", "shadowed_variable")
		var backupVelocityAMais = 0
		beanAtivado = false
		peidoIMG.position.x = 3000

# a cada 2 segundos aparecer um cara
func _on_timer_timeout() -> void:
	var enemy = enemy_scene.instantiate()
	var tela = get_viewport().size
	enemy.position.y = randi_range(100, tela.y - 100)
	enemy.position.x = tela.x + 100
	get_parent().add_child(enemy)
