extends Label

export var speed: float = 500.0
export var lastPosition: Vector2 = Vector2(0,0) setget refreshLblPos
export var eventName: String = "Unknown" setget refreshLblEName
export var eventsAgo: int = 0  setget refreshLblEventsAgo
export var fnt = preload("res://Font.tres")
export var from: String = "unknown"
export var dotColor: Color
export var dotText: String

func refreshLblEventsAgo(newVal):
	if newVal <= 0:
		self.modulate.a = 1
	eventsAgo = newVal
	updateText()

func refreshLblEName(newVal):
	eventName = newVal
	self.modulate.a = 1
	updateText()

func refreshLblPos(newVal):
	lastPosition = newVal
	self.modulate.a = 1
	updateText()

func updateText():
	self.text = eventName + " via " + from + " - last seen " + str(eventsAgo) + " events ago - " + str(lastPosition)

func _ready():
	pass 

func _draw():
	if lastPosition != Vector2(0,0):

		var targetPos = lastPosition - self.rect_global_position
		if eventName == "InputEventPanGesture":
			targetPos = get_tree().get_root().get_viewport().get_visible_rect().size / 2 + lastPosition - self.rect_global_position

		draw_circle(targetPos,30,dotColor)
		draw_string(fnt,targetPos,dotText,Color(0,0,0,.5))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if self.modulate.a > 0:
		self.modulate.a = self.modulate.a - 1.0 / speed
	else:
		self.visible = false
	
