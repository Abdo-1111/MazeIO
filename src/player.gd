extends KinematicBody2D



var speed
var tilemap

func _ready():
	tilemap = get_parent().get_node("TileMap")

func movement():
	var velocity = Vector2(Input.get_action_strength("ui_right")-Input.get_action_strength("ui_left") , Input.get_action_strength("ui_down")-Input.get_action_strength("ui_up"))
	move_and_slide(velocity*speed)

func _physics_process(delta):
	movement()




func _on_Area2D_body_entered(body):
	if body.name == "goal":
		get_tree().change_scene("res://scenes/win.tscn")

