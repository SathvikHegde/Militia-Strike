extends KinematicBody2D
class_name Player

export (int) var speed = 100;

onready var health = $Health;
onready var weapon = $Weapon;

signal playerFiredBullet(bullet, position, direction);

func _ready():
	weapon.connect("weaponFired", self, "shootBullet");

func _physics_process(delta):
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
	if event.is_action_pressed("mouse1"):
		weapon.shootBullet();

func shootBullet(bullet, position: Vector2, direction: Vector2):
	emit_signal("playerFiredBullet", bullet, position, direction);

func handleHit():
	health.health -= 30;
	print("Player got hit. Health: ", health.health);
