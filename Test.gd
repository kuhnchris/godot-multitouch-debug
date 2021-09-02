extends GridContainer

var lastDetect = {}
var labelSafe = {}
var labelPrefab = preload("res://Label.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	self.rect_size = get_tree().get_root().get_viewport().get_visible_rect().size

func addMsg(text):
	var t = OS.get_time()
	var tTxt = str(t["hour"]) + ":" + str(t["minute"]) + ":" + str(t["second"])
	$RichTextLabel.text = ("["+tTxt+"] "+text+"\n") + $RichTextLabel.text
	print_debug(tTxt," ",text)

func handleInput(event, from):
	var evIdx = event.get_class()
	if "index" in event:
		evIdx = evIdx + str(event.index)

	if evIdx in labelSafe:
		if "position" in event:
			labelSafe[evIdx].lastPosition = event.position
		labelSafe[evIdx].eventsAgo = 0
		labelSafe[evIdx].from = from
	else:
		labelSafe[evIdx] = labelPrefab.instance()
		labelSafe[evIdx].from = from
		labelSafe[evIdx].eventName = event.get_class()
		labelSafe[evIdx].eventsAgo = 0
		labelSafe[evIdx].dotText = labelSafe[evIdx].eventName.replace("InputEvent","")
		labelSafe[evIdx].dotColor = Color(rand_range(0,1),rand_range(0,1),rand_range(0,1),1)
		if "index" in event:
			labelSafe[evIdx].eventName = event.get_class() + " - " + str(event.index)
			labelSafe[evIdx].dotText = labelSafe[evIdx].dotText + str(event.index)
		if "position" in event:
			labelSafe[evIdx].lastPosition = event.position
		add_child(labelSafe[evIdx])

	for i in labelSafe.keys():
		labelSafe[i].eventsAgo = labelSafe[i].eventsAgo + 1

func _gui_input(event):
	handleInput(event, "_gui_input")


func _unhandled_input(event):
	handleInput(event, "_unhandled_input")
	#$RichTextLabel.clear()draw_circle(event.position,40,Color.white)
	
	#if event is InputEventGesture:
	#	lastDetect["gesture"] = 0
	#	addMsg("Gesture detected!")
	#if event is InputEventMagnifyGesture:
	#	lastDetect["magnify"] = 0
	#	addMsg("Magnify Gesture detected!")
	#if event is InputEventPanGesture:
	#	lastDetect["pan"] = 0
	#	addMsg("Pan Gesture detected!")
	#	var a: InputEventPanGesture = event
	#	addMsg("Delta: "+str(a.delta))
	#if event is InputEventScreenDrag:
	#	lastDetect["drag"] = 0
	#	addMsg("Screen Drag detected!")
	#if event is InputEventScreenTouch:
	#	lastDetect["touch"] = 0
	#	addMsg("Screen touch detected!")
	#	var t: InputEventScreenTouch = event
	#	addMsg("Was it touched? "+str(t.pressed))
	#	addMsg("Index: "+str(t.index))
	#	addMsg("Position: "+str(t.position))

	#for i in lastDetect.keys():
	#	addMsg("Event "+i+" last detected "+str(lastDetect[i])+" events ago.")
	#	lastDetect[i] = lastDetect[i] + 1

	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

