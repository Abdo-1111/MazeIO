extends TileMap


var size = 1
var width = 34
var height = 20
var visited = []
var stack = []
var directions = [Vector2(1,0),Vector2(-1,0),Vector2(0,1),Vector2(0,-1)]
var Fdirections = []
var start = Vector2(1,1)
var nextCell = Vector2(1,1)
var randomDirection = Vector2.ZERO
var temp
var show = false
var player
var cells
var goal
var choice
var cX = 1
var cY = 1
func _ready():
	
	goal = get_parent().get_node("goal")
	loadSize()
	loadSpeed()
	loadAlgo()
	if size == 0 :
		size = 1
	width *= size
	height *= size
	scale /= size
	goal.scale /= size
	player.scale /= size
	player.position = map_to_world(Vector2(1,1))/size
	player.speed /= size
	cells = width*height/4-1

	randomize()
	makeGrid()
	

	while visited.size() <= cells:
		maze(nextCell)

		
		



			
func makeGrid():
	for y in range(height+1):
		for x in range(width+1):
			if y % 2 == 0 :
				set_cell(x,y,0)
			if x % 2 == 0 :
				set_cell(x,y,0)
	goal.set_cell(width-1,height-1,0)
	goal.set_cell(width,height-1,0)

				
func maze(c):
	if choice == 0 :
		DepthAlgorithm(nextCell)

	if choice == 1 :
		HuntAndKill(nextCell)


func DepthAlgorithm(p):
	Fdirections = [Vector2(1,0),Vector2(-1,0),Vector2(0,1),Vector2(0,-1)]
	if p.x <=  1:
		Fdirections.erase(Vector2(-1,0))  
	if p.y <= 1 :
		Fdirections.erase(Vector2(0,-1))
	if p.x >= width - 2 :
		Fdirections.erase(Vector2(1,0))
	if p.y >= height - 2 :
		Fdirections.erase(Vector2(0,1))
		
	for i in directions:
		temp = p + i*2
		if temp in visited:
			Fdirections.erase(i)
	
	if Fdirections.size() == 0 :
		if !(p in visited) :
			visited.append(p)
		if stack.size() != 0:
			stack.erase(stack[stack.size()-1])
			nextCell = stack[stack.size()-1]
	else:	
		randomDirection = Fdirections[randi()%Fdirections.size()]
		nextCell = p+randomDirection*2
		stack.append(nextCell)
		visited.append(nextCell)
		removeWall(p+randomDirection)
	
func HuntAndKill(p):
	var stop = false
	Fdirections = [Vector2(1,0),Vector2(-1,0),Vector2(0,1),Vector2(0,-1)]

	if !(p in visited) :
		visited.append(p)

	if p.x <=  1:
		Fdirections.erase(Vector2(-1,0))  
	if p.y <= 1 :
		Fdirections.erase(Vector2(0,-1))
	if p.x >= width - 2 :
		Fdirections.erase(Vector2(1,0))
	if p.y >= height - 2 :
		Fdirections.erase(Vector2(0,1))
		
	for i in directions:
		temp = p + i*2
		if temp in visited:
			Fdirections.erase(i)
			
	if Fdirections.size() == 0 :
		if cX+1 == width:
			cY += 2
			cX = 1
		else:
			cX += 2
		nextCell = Vector2(cX,cY)
				
	else:	
		randomDirection = Fdirections[randi()%Fdirections.size()]
		nextCell = p+randomDirection*2
		visited.append(nextCell)
		removeWall(p+randomDirection)
		
func removeWall(a):
	set_cell(a.x,a.y,-1)
	
func loadSize():
	var fileSize = File.new()
	fileSize.open("user://size.save", File.READ)
	size = int(fileSize.get_line())
	fileSize.close()
	
func loadSpeed():
	player = get_parent().get_node("player")
	var fileSpeed = File.new()
	fileSpeed.open("user://speed.save", File.READ)
	player.speed = int(fileSpeed.get_line())
	fileSpeed.close()

func loadAlgo():
	var fileAlgo = File.new()
	fileAlgo.open("user://algorithm.save", File.READ)
	choice = int(fileAlgo.get_line())
	fileAlgo.close()

func _on_Button_pressed():
	get_tree().change_scene("res://scenes/menu.tscn")


func _on_reset_pressed():
	player.position = map_to_world(Vector2(1,1))/size


