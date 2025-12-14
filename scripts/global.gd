extends Node

var score = 0
var enemyVelocity = 100
var best_score: int = 0
const SAVE_FILE := "user://savegame.save"
var best = false
var bean = 3
var rifle = 0
var cooldown = 0
var feijaoativado = false

func _ready() -> void:
	if FileAccess.file_exists(SAVE_FILE):
		var file = FileAccess.open(SAVE_FILE, FileAccess.READ)
		if file:
			best_score = int(file.get_line())
			file.close()
		else:
			best_score = 0
		print("Melhor score carregado:", best_score)
