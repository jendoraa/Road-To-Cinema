extends TextureProgressBar

@onready var icon = $IconScore/RemoteTransform2D/ProgressbarIcon

func _process(_delta):
	var ratio = float(value) / max_value
	
	var bar_length = size.x 
	
	icon.position.x = ratio * bar_length
