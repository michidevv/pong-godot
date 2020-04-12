extends Node2D

var score_map = {"1": 0, "2": 0}

func _on_Ball_scored_point(player):
	var value = score_map.get(player)
	score_map[player] = value + 1
	$HUD.update_score(score_map)
