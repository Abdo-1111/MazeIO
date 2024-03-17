extends Control


onready var algorithmOption = $algorithmOption
var algorithms = ["depth","huntandkill"]
var algorithm = 0
func _ready():
	loadSize()
	loadSpeed()
	addOptions()
	loadAlgo()
	

	
func _on_backtomenu_pressed():
	get_tree().change_scene("res://scenes/menu.tscn")


func _on_save_pressed():
	var fileSize = File.new()
	fileSize.open("user://size.save", File.WRITE)
	fileSize.store_line($mazeSize.text)
	fileSize.close()

	var fileSpeed = File.new()
	fileSpeed.open("user://speed.save", File.WRITE)
	fileSpeed.store_line($playerSpeed.text)
	fileSpeed.close()
	
	var fileAlgorithm = File.new()
	fileAlgorithm.open("user://algorithm.save", File.WRITE)
	fileAlgorithm.store_line(str(algorithm))
	fileAlgorithm.close()



func _on_reset_pressed():
	var fileSize = File.new()
	fileSize.open("user://size.save", File.READ)
	$mazeSize.text = fileSize.get_line()
	fileSize.close()
	var fileSpeed = File.new()
	fileSpeed.open("user://speed.save", File.READ)
	$playerSpeed.text = fileSpeed.get_line()
	fileSpeed.close()

func loadSize():
	var fileSize = File.new()
	fileSize.open("user://size.save", File.READ)
	$mazeSize.text = fileSize.get_line()
	fileSize.close()
	
func loadSpeed():
	var fileSpeed = File.new()
	fileSpeed.open("user://speed.save", File.READ)
	$playerSpeed.text = fileSpeed.get_line()
	fileSpeed.close()

func loadAlgo():
	var file = File.new()
	file.open("user://algorithm.save", File.READ)
	algorithmOption.select(int(file.get_line()))
	file.close()
	
func addOptions():
	for i in algorithms:
		algorithmOption.add_item(i)


func _on_algorithmOption_item_selected(index):
	algorithm = index
