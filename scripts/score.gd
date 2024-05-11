extends Label

var score = 0

@onready var score_label = $"."
@onready var timer = $Timer

var pos
func _ready():
	timer.start()

func _process(delta):
	score_label.text = "Score: " + str(score)

func _on_timer_timeout():
	score += 1
	timer.start()
