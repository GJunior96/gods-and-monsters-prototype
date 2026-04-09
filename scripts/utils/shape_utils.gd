class_name ShapeUtils

static func arc(radius: float, thickness: float, angle: float, steps := 12) -> PackedVector2Array:
	var points := []

	var start_angle = deg_to_rad(-angle / 2)
	var end_angle = deg_to_rad(angle / 2)

	# outer
	for i in range(steps + 1):
		var t = i / float(steps)
		var a = lerp(start_angle, end_angle, t)

		#var outer = Vector2(cos(a), -sin(a)) * radius
		#points.append(outer)

		var dir = Vector2(cos(a), sin(a))

		var taper = sin(t * PI) # taper de 0 a 1 a 0 para criar um efeito de "afunilamento" no início e fim do arco
		var offset = thickness * (1.0 - taper) * 0.5 # offset para manter o centro do arco consistente

		points.append(dir * (radius - offset))

	for i in range(steps, -1, -1):
		var t = i / float(steps)
		var a = lerp(start_angle, end_angle, t)

		#var inner = Vector2(cos(a), sin(a)) * (radius - thickness)
		#points.append(inner)
		
		var dir = Vector2(cos(a), sin(a))

		var taper = sin(t * PI) # mesmo taper para a parte interna
		#var current_thickness = thickness * taper
		var offset = thickness * (1.0 - taper) * 0.5 # mesmo offset para manter o centro consistente

		points.append(dir * (radius - thickness + offset))


	return points