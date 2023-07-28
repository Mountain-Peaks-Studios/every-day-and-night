# Create an empty stack
var myStack = []

# Push an element onto the stack
func push(item):
	myStack.append(item)

# Pop an element from the stack
func pop():
	if myStack.size() > 0:
		return myStack.pop()
	else:
		return null

# Check if the stack is empty
func is_empty():
	return myStack.size() == 0

# Get the number of elements in the stack
func size():
	return myStack.size()

# Get the top element of the stack without removing it
func peek():
	if myStack.size() > 0:
		return myStack[myStack.size() - 1]
	else:
		return null
