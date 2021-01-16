extends KinematicBody
var pointlist = [[50,0,10], [5,0,30] ,[20,0,0]]
var speed = 20
var number_of_points = len(pointlist)
var i = 0
var a = null
var b = null
func _process(delta):
	
	for p in pointlist:
		a = p[0]
		b = p[2]
		var point =Vector3(a, 0, b) 
		
		var direction
		if point.distance_to(transform.origin) > 0.05:
			direction = point - transform.origin
			direction = direction.normalized() * speed

		else:
			direction = point - transform.origin

		move_and_slide(direction)



