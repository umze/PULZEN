extends Node2D

var enemy_scene = preload("res://cenas/enemy.tscn")

func _ready() -> void:
	var screenSize = get_viewport().size
	
	var text = $FimDeJogo
	text.z_index = 10
	text.position.x = screenSize.x / 2 - 317.5
	text.position.y = screenSize.y / 2 - 117
	
	var score = $Scorew
	score.z_index = 11
	score.position.x = screenSize.x / 2 - 288
	score.position.y = screenSize.y / 2 - 45.5 + 60
	score.text = "Pontuação: " + str(Global.score)
	if Global.best:
		score.text += "\nNovo recorde!"
	else:
		score.text += "\nMelhor pontuação: " + str(Global.best_score)
		
	var playAgain = $PlayAgain
	playAgain.z_index = 12
	playAgain.position.x = screenSize.x / 2 - 188.5 - 200
	playAgain.position.y = screenSize.y / 2 - 62 + 200
	
	var notPlayAgain = $NoPlayAgain
	notPlayAgain.z_index = 13
	notPlayAgain.position.x = screenSize.x / 2 - 188.5 + 200
	notPlayAgain.position.y = screenSize.y / 2 - 62 + 200
	
# a cada 2 segundos aparecer um cara
func _on_timer_timeout() -> void:
	var enemy = enemy_scene.instantiate()
	var tela = get_viewport().size
	enemy.position.y = randi_range(100, tela.y - 100)
	enemy.position.x = tela.x + 100
	get_parent().add_child(enemy)


func _on_play_again_pressed() -> void:
	Global.score = 0
	Global.enemyVelocity = 100
	var cursor = load("res://sprites/crosshair.png")
	Input.set_custom_mouse_cursor(cursor)
	get_tree().call_group("enemy", "queue_free")
	get_tree().change_scene_to_file("res://cenas/jogo.tscn")


func _on_no_play_again_pressed() -> void:
	get_tree().quit()
