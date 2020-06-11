extends TileMap


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
#this code is currently broken but it does work with odd number square grids
var mapHeight=7
var mapLength=7
var cellSize=7
#visitedCells is a dict just so i can have quick lookup
#doesn't matter in this case but still nice
var visitedCells={}


# Called when the node enters the scene tree for the first time.
func _ready():
	#implementing hunt and seek algorithm:
	#create grid of MxN big square tiles which are S tiles on a side
	for i in range(mapLength):
		for j in range(mapHeight):
			createSquare(i, j)
	#set_cellv(Vector2(0,0),0)
	#deleteBoundary(1,1,3)
	#return
	var startX= getRandomNumber(mapLength)
	var startY= getRandomNumber(mapHeight)
	var currCell=Vector2(startX,startY)
	#random walk until you hit dead end, then start at upper left corner and try to find tile
		#that is unoccupied
	while(visitedCells.size()<cellSize*cellSize):
		#hacky but doing this because there's no set like java/python
		visitedCells[currCell]=0
		var newPos
		#if it's a dead end search for new unvisited square with visited neighbor
		# starting from top left
		#when you find that square connect it to visited neighbor
		if(isDeadEnd(currCell)):
			var found=false
			for m in range(mapLength):
				if(found): break
				for n in range(mapHeight):
					if(!visitedCells.has(Vector2(m, n))):
						currCell = Vector2(m, n)
						for q in range(4):
							if(visitedCells.has(getCoords(currCell, q))):
								deleteBoundary(currCell.x, currCell.y, q)
								break
						found=true
						break
			continue
					
				
		else:
			#if it's not a dead end go in random direction
			#potentially could get hung here but probably not
			var orient
			while(true):
				orient = getRandomNumber(4)
				newPos= getCoords(currCell, orient)
				if(!isOutOfBounds(newPos.x, newPos.y)&&!visitedCells.has(newPos)): 
					break
			deleteBoundary(currCell.x, currCell.y, orient)
			currCell= newPos
			
		#you know you're at dead end if all the tiles around you are already occupied or not in the map
		#random walk cuts away S-2 little tiles from the middle of the big tile
		#need to maintain list of already visited tiles internally
		#can probably make a separate function here to create enemies and path to other room, dont
		#need to
	pass # Replace with function body.

func createSquare(x, y):
	for m in range(cellSize):
				for n in range(cellSize):
					set_cellv(Vector2(x*(cellSize)+m,y*(cellSize)+n),0)
	for m in range(cellSize-2):
				for n in range(cellSize-2):
					set_cellv(Vector2((x)*(cellSize)+1+m,(y)*(cellSize)+1+n),-1)


func deleteBoundary(x,y,orient):
	#left, right, up, down
	if(orient==0):
		for m in range(2):
			for n in range(cellSize-2):
				set_cellv(Vector2(x*cellSize-m, y*cellSize+1+n),-1)
	if(orient==1):
		for m in range(2):
			for n in range(cellSize-2):
				set_cellv(Vector2((x+1)*cellSize+m-1, y*cellSize+1+n),-1)
	if(orient==2):
		for m in range(cellSize-2):
			for n in range(2):
				set_cellv(Vector2(x*cellSize+1+m, y*cellSize-n),-1)
	if(orient==3):
		for m in range(cellSize-2):
			for n in range(2):
				set_cellv(Vector2(x*cellSize+1+m, (y+1)*cellSize+n-1),-1)
				
func getRandomNumber(n):
	randomize()
	return randi()%n
	
func isOutOfBounds(x, y):
	return x<0||y<0||x>=cellSize||y>=cellSize
	
func isDeadEnd(pos):
	for i in range(4):
		var newPos =getCoords(pos, i)
		if(!isOutOfBounds(newPos.x,newPos.y)&&!visitedCells.has(newPos)):
			return false
	return true
	
func getCoords(pos, orient):
	if(orient==0):
		return Vector2(pos.x-1, pos.y)
	if(orient==1):
		return Vector2(pos.x+1, pos.y)
	if(orient==2):
		return Vector2(pos.x, pos.y-1)
	if(orient==3):
		return Vector2(pos.x, pos.y+1)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
