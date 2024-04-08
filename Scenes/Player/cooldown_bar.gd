class_name CooldownBar extends ProgressBar


func _process(delta):
	if $CooldownTimer.time_left >= 0.01:
		value = $CooldownTimer.time_left
	else: value = max_value
