extends KinematicBody2D

const SPEED = 250
var prev_shooting = false
var killed = false

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
	var shooting = Input.is_action_pressed("ui_space")
	
	if (shooting and not prev_shooting):
		var player_bullet = preload("res://Scenes/player_bullet.tscn")
		player_bullet.set_post(get_node("bullet_spawn").get_global_pos())
		get_node("../..").add_child(player_bullet)