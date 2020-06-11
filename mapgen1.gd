extends TileMap

var _tileset
var locToIDMap ={}
#following var gives type list(0 for fully open, 1 for 2 open straight,
#2 for 3 open, 3 for corner, 4 for dead end)
#lists all possible id values for each type
var typeList

var openList

func _ready():
	_tileset = get_tileset()
	var currPos=Vector2(16,16)
	var iter = 0
	#rooms that haven't been iterated over the neighbors
	#array of vector2s, where first entry is a vec2 of position, and 2nd entry is iter depth
	var unexpandedSpaces=[]
	set_process_input(false)
	#create all rooms and add player object in one of them,
	#set camera center to player object
	#for now, create vectors but see if 
	print("test")
	#set_cellv(Vector2(2, 5), _tileset.find_tile_by_name("botb"))
	#metatile id list:
	#0 is all open (subtype 0)
	#1 and 2 are horiz and vert open (subtype 1)
	#3,4,5,6 are left right up down 1 closed (subtype 2)
	#7, 8, 9, 10 are  lu, ru, rd, ld corners (subtype 3)
	#11, 12, 13, 14 are l,r, u, d 1 open (subtype 4)
	#id 15 is just a closed block for testing
	#all metatiles are already defined in the editor starting from 0, -5
	#start by placing an id 0 metatile at 80,80 or something
	getandPutMetatileVec(0,currPos)
	unexpandedSpaces.append(Vector3(currPos[0], currPos[1], 0))
	#iterate through adjacent open slots with while
	#killswitch is just to kill infinite loops
	var killswitch=0
	while(unexpandedSpaces.size()>0 && killswitch < 40):
		killswitch+=1
		print("comb")
		#get 0th node in list
		currPos = Vector2(unexpandedSpaces[0][0],unexpandedSpaces[0][1])
		var currIter = unexpandedSpaces[0][2]
		var currId= locToIDMap.get(currPos)
		#iterate over neighbors
		#if isTileOpenOnSide get random metatile for that location
		for i in range(4):
			#check if tile is open and if there isn't a tile there currently
			#print(str(locToIDMap)+ " and " + str(currPos))
			if(isTileOpenOnSide(locToIDMap.get(currPos),i)):
				# put metatile at that spot
				#var tileID = getRandomMetatile(currPos[1], currId, i)
				var tileID = getRandomMetatileSimple(currIter)
				var newPos =getNewTilePos(currPos, i)
				getandPutMetatileVec(tileID, newPos)
				unexpandedSpaces.append(Vector3(newPos[0], newPos[1], currIter+1))
		#remove 0th node and increment when done
		unexpandedSpaces.remove(0)
	#(id 0, 1,2, and 3-6)
	#make
	#add player in the last block generated, set camera to center on them
	getandPutMetatile(1,1,1)
	#var curCell = set_cellv(Vector2(0,0), get_cell(4, -5))
	set_process_input(true)

func getandPutMetatileVec(id,cellPos):
	getandPutMetatile(id, cellPos[0], cellPos[1])
	
#id is metatile id, x and y is metatile coord(starts at 0, increments by 5)
func getandPutMetatile(id,x,y):
	print("wingo")
	#make variable i which starts at 0 and ends at 4,
	for i in range(5):
	#and var j which starts at 0 and ends at 4
	#getting empty tile returns -1 which is added as empty tile
	#iterate on X=6*id+i and Y= 5-j for top left to bottom right
		for j in range(5):
			var pos =Vector2((x*5)+i,(y*5)+j)
			set_cellv(pos,get_cell(6*id+i, -5+j))
			#add key=vec2 for position and value=id to locToIdMap
	locToIDMap[Vector2(x, y)]=id
	
#this function is for testing	
func getRandomMetatileSimple(iter):
	print("boomb")
	var rando
	if(iter < 5):
		randomize()
		rando = randi()%15
		print(str(rando))
		return rando
	else:
		return 15
	#get totally random metatile from 0 to 14, until iter is 4, then just return only 15, which
	#should kill the map generation
	
#following func is to get random metatile id
#iter is iteration value
#id is id of central metatile
#pos is vec2 with position of metatile
#orient is 0,1,2,3 for left right up down orientation
func getRandomMetatile(iter, id, orient):
	print("boomb")
	#to make it easier for yourself, first implement it so that all 
	
	
	
	
	#place metatiles in all
	#if iter is less than or equal 4, chance of type 2 is 50%, chance of type 1 is 25%,
	#chance of type 3 25%
	#if it's greater than 4 and less than 6, chance of type 1 is 25%, chance of type 3 25%,
	# chance of type 4 50%
	#if greater than 6, chance of type 4 is 100% (close off level)
	#for each case, get list off possible id values for type, then filter out
	#the ones that are not open on the opposite side.
	#then select at random

#following is to check if a tile can be placed next to another one
#orient is pne side of the current tile (0,1,2,3 lrud)
func isTileOpenOnSide(id, orient):
	print("bepis")
	#get tile in the middle of that side
	var x=-1
	var y=-1
	match orient:
		0:
			x = 0
			y = 2
		1:
			x = 4
			y = 2
		2:
			x = 2
			y = 0
		3:
			x=2
			y=4
	print(str(get_cell(6*id+x, -5+y)))
	return  get_cell(6*id+x, -5+y) == -1
	#if there is a tile return false
	
func getNewTilePos(loc, orient):
	if(orient==0): return Vector2(loc[0]-1, loc[1]);
	if(orient==1): return Vector2(loc[0]+1, loc[1]);
	if(orient==2): return Vector2(loc[0], loc[1]-1);
	if(orient==3): return Vector2(loc[0], loc[1]+1);

#gets opposite side id
func getOppositeSide(orient):
	if(orient==0): return 1;
	if(orient==1): return 0;
	if(orient==2): return 3;
	if(orient==3): return 2;
	
#func _input(event):
#	var tile_pos = world_to_map(event.pos)
#	if event.is_action_pressed("add_tower"):
#		set_cellv(tile_pos, _tileset.find_tile_by_name("FireTower"))
