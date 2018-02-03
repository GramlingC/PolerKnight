extends RigidBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var clicked = false
var moving = false
var c = 15
var r = 30
var enemy = preload("res://enemy.gd")
var currentForce = Vector2(0,0)
var label
var total = 0
var maxspeed = 0
var time = 0
var count = 0

func _input(ev):
	pass
	
func analog_force_change(newForce, analog):
	currentForce = newForce
	

func impulse(ev):
	if (ev == 3):
		clicked = !clicked
		
		if (!clicked):
			#OS.set_time_scale(1)
			#get_child(1).set_scale(get_child(1).get_scale()/100)
			#get_child(0).set_pos(get_pos()+Vector2(0,75))
			#get_child(1).set_pos(get_pos()+Vector2(0,0))
			#get_child(1).set_pos(get_pos()+Vector2(0,75))
			pass
			#print(get_child(1).get_scale())
			#set_angular_damp(10)
		else:
			#OS.set_time_scale(0.1)
			#get_child(1).set_scale(get_child(1).get_scale()*100)
			#get_child(0).set_pos(get_pos()+Vector2(0,100))
			
			if (r == 30):
				#set_linear_velocity(Vector2(sin(get_rot())*200,cos(get_rot())*200))
				#get_parent().set_linear_velocity(get_parent().get_linear_velocity()+get_linear_velocity())
				moving = true
			r = 0
				
			#c = 15;
			#get_child(1).set_pos(get_pos()+Vector2(0,100))
			pass
			#print(get_child(1).get_scale())
			#set_angular_damp(40)
	elif(ev == 2):
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
		get_child(1).set_pos(get_pos()+Vector2(0,85-(3*c)))
		
	if (clicked && c > 0):
		
		c -= 1
		#set_pos(get_pos()-Vector2(sin(get_rot())*(10-(1*c)),cos(get_rot())*(10-(1*c))))
		get_child(0).set_pos(get_pos()+Vector2(0,65-(3*c)))
		get_child(1).set_pos(get_pos()+Vector2(0,85-(3*c)))
		
	else:
		moving = false
		
	if (moving):
		
		if (r < 10):
			apply_impulse(Vector2(0,0),5*Vector2(sin(get_rot())*30,cos(get_rot())*30))
			#get_parent().set_linear_velocity(get_parent().get_linear_velocity()+get_linear_velocity())
		#get_parent().set_linear_velocity(Vector2(sin(get_rot())*300,cos(get_rot())*300))
		#var ximpulse = abs(get_pos().x)*10
		#var yimpulse = abs(get_pos().y)*10
		#var impulse = ximpulse+yimpulse
		#if (impulse >= 1):
		#	impulse = 1
		#	impulse(2)

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
	
	if (delta > 0):
		var momentum = get_parent().get_linear_velocity().length()*get_parent().get_mass()
		if ( momentum < 1500):
			set_friction(1 - (momentum/1500))
		else:
			set_friction(0)
		time += delta
		count += 1
		total += momentum
		if (momentum > maxspeed):
			maxspeed = momentum
		label.set_text("Current: " + str(int(momentum)) + ", Max: " + str(int(maxspeed)) + ", Time: "+ str(round(time*100)/100)+", Average: "+ str(int(total/count)))
	
func _integrate_forces(s):

	for x in range(s.get_contact_count()):
			var ci = s.get_contact_local_normal(x)
			
			if (moving):
				
				var mod = ci.dot(Vector2(-sin(get_rot()),-cos(get_rot())))

				var yrot = -sign(cos(get_rot()))*(1+abs(cos(get_rot())))/2
				var xrot = -sin(get_rot())
				var t = c 
				if (c > 8):
					t = (15+c)/2
			#print(t)
			#print(impulse)
				#set_linear_velocity(get_linear_velocity()/2)
				var base = (80 + (mod * 40))#*t
				apply_impulse(Vector2(0,0),Vector2(t*xrot*(base + 50 * abs(ci.x)),t*yrot*(base + 50 * (.5+abs(ci.y))/1.5)))
				#get_parent().set_linear_velocity(get_linear_velocity())
				moving = false 
				r= 30
				var l = s.get_contact_collider_object(x)
				if (l extends enemy):
					l.direction = -l.direction
					l.get_node("sprite").set_scale(Vector2(-l.direction*6, 6))
					l.moving = true
	
	
	#rotate(PI/4)
	

func _ready():
	label = get_node("/root/stage/Node2D/CanvasLayer/Label")
	#get_child(1).set_scale(get_child(1).get_scale()/100)
	set_process_input(true)
	set_process(true)
	
	#rotate(PI/4)
	