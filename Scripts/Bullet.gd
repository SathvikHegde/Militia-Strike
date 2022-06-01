extends Area2D

export (int) var speed = 100;

var direction = Vector2.ZERO;


func _physics_process(delta):
	if direction != Vector2.ZERO:
		var velocity = direction * speed;
		
		global_position += velocity;

func setDirection(direction: Vector2):
	self.direction = direction;
