extends Resource

var items = Array()

func _ready() -> void:
	# Create directory of all items in game
	var directory = DirAccess.open("res://items/directory/")
	directory.list_dir_begin()
	
	# Access the first file from the directory
	var filename = directory.get_next()
	
	# Add items to the 'items' array
	while(filename):
		# Check if a file is being checked (and not a directory itself) 
		if not directory.current_is_dir(): 
			items.append(load("res://Items/%s" % filename))
		
		filename = directory.get_next() # Next item
	
