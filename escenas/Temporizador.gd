extends Label
var DisplayValue = 60;
onready var Timer = get_node("Timer")
func _ready():
	Timer.wait_time = 1;
	Timer.start();

func _on_Timer_timeout():
	if DisplayValue!=0:
		DisplayValue -= 1;
	else:
		get_parent()._Game_Over()
	text = "Time\n"+str(DisplayValue);
