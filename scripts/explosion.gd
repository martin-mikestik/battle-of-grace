extends Area2D



	
func explode():
	print("explosion launched")
	var tween = create_tween()
	
	tween.tween_property(self, "scale", Vector2(scale.x * 2, scale.y * 2), 0.2
	
	)
	
	await tween.finished
	print("finished")
	queue_free()
