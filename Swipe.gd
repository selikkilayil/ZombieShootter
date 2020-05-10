extends Node2D


signal swipe
signal stop
var swipe_start = null
var minimum_drag = 100
onready var timer: Timer = $Timer

func _unhandled_input(event):
#	if event.is_action_pressed("mb_left"):
#		swipe_start = get_global_mouse_position()
#	if event.is_action_released("mb_left"):
#		_calculate_swipe(get_global_mouse_position())
	if not event is InputEventScreenTouch:
		return
	if event.pressed:
		if swipe_start == null:
			swipe_start =event.position
		else:
			_calculate_swipe(event.position)
	elif !event.pressed:
		emit_signal("stop")
#	elif not timer.is_stopped():
#		_calculate_swipe(event.position)

func _calculate_swipe(swipe_end):
	timer.stop()
	if swipe_start == null: 
		return
	var swipe = swipe_end - swipe_start
	print(swipe)
#if abs(swipe.x) > minimum_drag:
	if swipe.x > 0:
		print("right")
		emit_signal("swipe", "right")
	else:
		print("left")
		emit_signal("swipe", "left")
