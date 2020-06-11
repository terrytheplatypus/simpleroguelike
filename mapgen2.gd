extends TileMap


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var mapHeight=7
var mapLength=7
var cellSize=7
var visitedCells=[]


# Called when the node enters the scene tree for the first time.
func _ready():
	#implementing hunt and seek algorithm:
	#create grid of MxN big square tiles which are S tiles on a side
	for i in range(mapLength):
		for j in range(mapHeight):
			createSquare(i, j)
	#set_cellv(Vector2(0,0),0)
	deleteBoundary(1,1,3)
	
	while(visitedCells.count()<cellSize*cellSize):
		#random walk until you hit dead end, then start at upper left corner and try to find tile
		#that is unoccupied
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
				
#func 

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
