extends CanvasLayer

onready var left_score = $LeftScore
onready var right_score = $RightScore

func _ready():
	left_score.text = "0"
	right_score.text = "0"

func update_score(map):
	left_score.text = str(map.get("1"))
	right_score.text = str(map.get("2"))
	
