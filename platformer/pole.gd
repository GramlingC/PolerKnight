extends RigidBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var clicked = false
var moving = false
var c = 15
var r = 30

var currentForce = Vector2(0,0)

func _input(ev):
	pass
	
func analog_force_change(newForce, analog):
	currentForce = newForce
	

func impulse(ev):
	if (ev == 3):
		clicked = !clicked
		
		if (!clicked):
			#get_child(1).set_scale(get_child(1).get_scale()/100)
			#get_child(0).set_pos(get_pos()+Vector2(0,75))
			#get_child(1).set_pos(get_pos()+Vector2(0,0))
			#get_child(1).set_pos(get_pos()+Vector2(0,75))
			pass
			#print(get_child(1).get_scale())
			#set_angular_damp(10)
		else:
			#get_child(1).set_scale(get_child(1).get_scale()*100)
			#get_child(0).set_pos(get_pos()+Vector2(0,100))
			
			if (r == 30):
				set_linear_velocity(Vector2(sin(get_rot())*200,cos(get_rot())*200))
				get_parent().set_linear_velocity(get_parent().get_linear_velocity()+get_linear_velocity())
				moving = true
			r = 0
				
			#c = 15;
			#get_child(1).set_pos(get_pos()+Vector2(0,100))
			pass
			#print(get_child(1).get_scale())
			#set_angular_damp(40)
	elif(ev == 2):
		print("printpulse")
		var ximpulse = abs(get_pos().x)*10
		var yimpulse = abs(get_pos().y)*10
		var impulse = 1# ximpulse+yimpulse
		if (impulse >= 1):
			impulse = 1
			var yrot = -sign(cos(get_rot()))*(1+abs(cos(get_rot())))/2
			var xrot = -sin(get_rot())
			var t = c
			if (c > 8):
				t = (15+c)/2
			#print(t)
			#print(impulse)
			set_linear_velocity(get_linear_velocity()+Vector2(xrot*(40*t),(yrot)*(40*t)))
			get_parent().set_linear_velocity(get_linear_velocity())
			moving = false 
			r= 30
		#print((ev.x-400)/10)
		#set_pos(ev.pos+get_node.)
		#+ Vector2(200,1000))
		
func _process(delta):
	#print((get_viewport().get_mouse_pos().x-400))
	if (!clicked && c < 15):
		c += 1
		get_child(0).set_pos(get_pos()+Vector2(0,65-(3*c)))
		get_child(1).set_pos(get_pos()+Vector2(0,65-(3*c)))
		
	if (clicked && c > 0):
		c -= 1
		#set_pos(get_pos()-Vector2(sin(get_rot())*(10-(1*c)),cos(get_rot())*(10-(1*c))))
		get_child(0).set_pos(get_pos()+Vector2(0,65-(3*c)))
		get_child(1).set_pos(get_pos()+Vector2(0,65-(3*c)))
		
	else:
		moving = false
		
	if (moving):
		
		if (r < 5):
			set_linear_velocity(Vector2(sin(get_rot())*30,cos(get_rot())*30))
			get_parent().set_linear_velocity(get_parent().get_linear_velocity()+get_linear_velocity())
		#get_parent().set_linear_velocity(Vector2(sin(get_rot())*300,cos(get_rot())*300))
		var ximpulse = abs(get_pos().x)*10
		var yimpulse = abs(get_pos().y)*10
		var impulse = ximpulse+yimpulse
		if (impulse >= 1):
			impulse = 1
			impulse(2)

	if(r<30):
		r += 1
		#if (c <= 0):
		#	moving = false
		#if (get_child(1).get_shape().collide_and_get_contacts(
					#pass
		#if (get_child(1).get_pos() <= get_child(0).get_pos()):
		#	get_child(1).set_pos(get_child(1).get_pos()+ Vector2(0,5))
		#else:
		#	get_child(1).set_pos(get_child(0).get_pos())
		#	moving = false
	#var angle = get_angle_to(get_global_mouse_pos())
	#if (abs(get_angle_to(get_global_mouse_pos())) > PI/2):
	#	angle = sign(get_angle_to(get_global_mouse_pos()))*PI/2
	#set_angular_velocity(-angle*5)
	#set_angular_damp(0)
	var angle = get_angle_to(Vector2(get_global_pos().x + currentForce.x,get_global_pos().y - currentForce.y))
	
	if (abs(angle) > PI/2):
		angle = sign(angle)*PI/2
	
	#print(angle)
	set_angular_velocity(-angle*6)
	
	
	
	
	#rotate(PI/4)
	

func _ready():
	#get_child(1).set_scale(get_child(1).get_scale()/100)
	set_process_input(true)
	set_process(true)
	#rotate(PI/4)
	