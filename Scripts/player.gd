extends KinematicBody2D

const SPEED = 250
var isShooting = false
var bullet = preload("res://Scenes/player_bullet.xml")
var bulletCount = 0
var killed = false
var bulletArray = []

func _ready():
    set_fixed_process(true)

func _fixed_process(delta):
	var direction = Vector2()

	### MOVEMENT CODE ####
	if Input.is_action_pressed("ui_down"):
	    direction.y += SPEED
	if Input.is_action_pressed("ui_up"):
	    direction.y += -SPEED
	if Input.is_action_pressed("ui_left"):
	    direction.x += -SPEED
	if Input.is_action_pressed("ui_right"):
	    direction.x += SPEED
	set_pos(get_pos() + direction.normalized() * SPEED * delta)

	### SHOOTING CODE ###
	if Input.is_action_pressed("ui_select"):
		if isShooting == false:
			shoot()
			isShooting = true
	else:
		isShooting = false
		
	#bulletarray code#
	for bullet in bulletArray:
		var bulletPos = get_node(bullet).get_pos()
		bulletPos.x = bulletPos.x + 200 * delta
		get_node(bullet).set_pos(bulletPos)
	
func shoot():
	print("shooting")
	bulletCount = bulletCount + 1
	var bullet_instance = bullet.instance()
	bullet_instance.set_name("bullet"+str(bulletCount))
	add_child(bullet_instance)
	var bulletPos = get_node("bullet"+str(bulletCount)).get_pos()
	var shipPos = get_node("bullet_spawn").get_pos()
	bulletPos.y = shipPos.y
	bulletPos.x = shipPos.x
	get_node("bullet"+str(bulletCount)).set_pos(bulletPos)
	bulletArray.append("bullet"+str(bulletCount))
	print(bulletArray)