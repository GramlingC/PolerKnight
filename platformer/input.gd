
extends Area2D
func _ready():
	set_process(true)
	
func _process(delta):
	#print(get_global_mouse_pos())
	if (get_pos().distance_to(get_global_mouse_pos()) < 200):
		var pole = get_node("/root/stage/player/plank1")
		var angle = pole.get_angle_to(pole.get_global_pos()+ get_local_mouse_pos())
		get_node("label").set_text(str(angle))
		if (abs(angle) > PI/2):
			angle = sign(angle)*PI/2
		pole.set_angular_velocity(-angle*5)
		
	
# Virtual from CollisionObject2D (also available as signal)
func _input_event(viewport, event, shape_idx):
	# Convert event to local coordinates
	if (event.type == InputEvent.MOUSE_MOTION):
		event = make_input_local(event)
		get_node("label").set_text(str(event.pos))
		var pole = get_node("/root/stage/player/plank1")
		var angle = pole.get_angle_to(pole.get_global_pos()+ event.pos)
		get_node("label").set_text(str(angle))
		if (abs(angle) > PI/2):
			angle = sign(angle)*PI/2
		pole.set_angular_velocity(-angle*5)


# Virtual from CollisionObject2D (also available as signal)
func _mouse_exit():
	#var text = get_viewport_rect()#.o#+Vector2(0,100)
	get_node("label").set_text("")
