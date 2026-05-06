extends CanvasLayer

@onready var HP_Label = $VBoxContainer/HP
@onready var score_label = $VBoxContainer/Score

func set_HP(health):
	HP_Label.text = "HP: " + str(health)

func set_score(score):
	score_label.text = "Score: " + str(score)
