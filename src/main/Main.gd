extends Node2D

onready var player: Node2D = $Player
onready var objective: Node2D = $Objective
onready var score_and_speed: Label = $UI/Control/Label
onready var game_over_overlay: Control = $GameOverLayer/GameOver
onready var final_score: Label = $GameOverLayer/GameOver/VBoxContainer/Label
onready var coin_sound: AudioStreamPlayer = $CoinSound

const SCORE_AND_SPEED_TEXT_FORMAT: String = "score: %s\nspeed: %s"

var direction: int = -1
var speed: float = 1
var clickable: bool = false
var score: float = 0

func _ready() -> void:
	game_over_overlay.visible = false
	score_and_speed.text = SCORE_AND_SPEED_TEXT_FORMAT % [score, speed]
	respawn_obective()

func _process(delta: float) -> void:
	player.rotate(delta * direction * speed)

func _on_Area2D_area_entered(area: Area2D) -> void:
	clickable = true

func _on_Area2D_area_exited(area: Area2D) -> void:
	clickable = false

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("click"):
		add_score() if clickable else game_over()

func add_score() -> void:
	score += 1
	direction *= -1
	speed += 0.2
	score_and_speed.text = SCORE_AND_SPEED_TEXT_FORMAT % [score, speed]
	respawn_obective()
	coin_sound.play()

func game_over() -> void:
	game_over_overlay.visible = true
	var final_score_value: float = speed * score
	final_score.text = "final score: " + str(final_score_value)

func respawn_obective() -> void:
	objective.rotate(rand_range(30, 210))

func _on_Button_button_up() -> void:
	get_tree().reload_current_scene()
