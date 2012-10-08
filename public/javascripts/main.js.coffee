$ ->

	flip = (current = false, chance = 0.5) ->
		flipped = Math.floor(Math.random() * (1 / chance)) == 1
		if flipped then !current else current

	stage = new fabric.StaticCanvas('stage');

	pixel_size = 10
	half_pixel_size = pixel_size / 2

	data = new CreatureData(3, 6)
	new_data = data.mutate(0.2)

	grid = new Grid()
	pixels = new CreatureFrame()
	new_pixels = pixels.mutate(0.2)

	frames = [pixels, new_pixels]

	# new_pixels.set 'fill', "red"
	new_pixels.visible = false

	stage.add pixels
	stage.add new_pixels
	stage.add grid

	last_time = new Date().getTime()
	animate = (time) ->

		dt = time - last_time

		if dt > 400
			last_time = time;

			for frame in frames
				frame.toggleVisible()

			stage.renderAll()

		requestAnimationFrame animate

	animate()