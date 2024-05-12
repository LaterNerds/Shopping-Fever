extends Label

@onready var score_label = $"."
@onready var timer = $Timer

var pos
func _ready():
	timer.start()

func _process(delta):
	score_label.text = "Score: " + str(GlobalVars.score)

func _on_timer_timeout():
	GlobalVars.score += 1
	timer.start()
