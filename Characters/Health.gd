extends Node2D

export (int) var health = 100 setget setHealth, getHealth;

func setHealth(newhealth: int):
	health = clamp(newhealth, 0, 100);

func getHealth():
	return health
