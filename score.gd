extends Label

var score = 0

func _process(delta):
	score += delta
	set_text(str(round_to_dec(score, 3) * 1000))

func round_to_dec(num, digit):
	return round(num * pow(10.0, digit)) / pow(10.0, digit)

func add_score(amount):
	score += amount / 1000
