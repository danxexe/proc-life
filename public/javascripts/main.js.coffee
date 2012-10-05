$ ->

	flip = (current = false, chance = 0.5) ->
		flipped = Math.floor(Math.random() * (1 / chance)) == 1
		if flipped then !current else current

	stage = new fabric.Canvas('stage');

	pixel_size = 10
	half_pixel_size = pixel_size / 2

	data = new CreatureData(3, 6)
	new_data = data.mutate(0.2)

	grid = new Grid()
	pixels = new CreatureFrame()
	# new_pixels = pixels.mutate(0.2)

	new_pixels = new fabric.Group()

	for row, y in new_data.rows

		row.push row[1], row[0]

		for p, x in row
			if p
				new_pixels.add new fabric.Rect
					top: y * pixel_size + half_pixel_size
					left: x * pixel_size + half_pixel_size
					width: pixel_size
					height: pixel_size

	frames = [pixels, new_pixels]

	new_pixels.set 'fill', "red"
	# new_pixels.set 'opacity', 0

	window.pixels = pixels

	stage.add pixels
	stage.add new_pixels
	stage.add grid

	last_time = new Date().getTime()
	animate = (time) ->

		dt = time - last_time

		if dt > 200
			last_time = time;

			for frame in frames
				new_opacity = if frame.get('opacity') == 0 then 1 else 0
				frame.set('opacity', new_opacity)

			stage.renderAll()

		requestAnimationFrame animate

	# animate()