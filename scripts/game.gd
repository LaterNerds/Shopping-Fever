extends Node2D

@onready var audio_stream_player = $AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	audio_stream_player.play()
	GlobalVars.score = 0
	GlobalVars.has_lysol = false
	GlobalVars.mask_protection = 0
	GlobalVars.in_covid = false
	GlobalVars.player_health = 100
	GlobalVars.player_global_pos



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if not audio_stream_player.playing:
		audio_stream_player.play()
