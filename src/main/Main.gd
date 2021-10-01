extends Node2D

onready var player: Node2D = $Player
onready var objective: Node2D = $Objective

var direction: int = -1
var speed: float = 1
var clickable: bool = false
var score: int = 0
var total_score: int = 0

func _ready() -> void:
	respawn_obective()

func _process(delta: float) -> void:
	player.rotate(delta * direction * speed)

func _on_Area2D_area_entered(area: Area2D) -> void:
	clickable = true

func _on_Area2D_area_exited(area: Area2D) -> void:
	clickable = false

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("click"):
		add_score() if clickable else game_over()

func add_score() -> void:
	score += 1
	direction *= -1
	speed += 0.2
	respawn_obective()

func game_over() -> void:
	print("score: ", score * speed)
	print("over")
	score = 0
	speed = 0

func respawn_obective() -> void:
	objective.rotate(rand_range(30, 270))
