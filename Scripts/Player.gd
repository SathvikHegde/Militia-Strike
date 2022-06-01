extends KinematicBody2D

export (int) var speed = 100;
export (PackedScene) var Bullet;

onready var endOfGun = $EndOfGun;

func _ready():
	pass 

func _process(delta):
	var direction = Vector2();
	
	if Input.is_action_pressed("up"):
		direction.y = -1;
	if Input.is_action_pressed("down"):
		direction.y = 1;
	if Input.is_action_pressed("right"):
		direction.x = 1;
	if Input.is_action_pressed("left"):
		direction.x = -1;
	
	direction = direction.normalized();
	
	move_and_slide(direction * speed);
	look_at(get_global_mouse_position());

func _unhandled_input(event):
	if event.is_action_released("mouse1"):
		shootBullet();

func shootBullet():
	var bulletInstance = Bullet.instance();
	add_child(bulletInstance);
	bulletInstance.global_position = endOfGun.global_position;
	var target = bulletInstance.global_position.direction_to(get_global_mouse_position()).normalized();
	bulletInstance.setDirection(target);
