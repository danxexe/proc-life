$ ->
	$('#stage').attr width: $(document).width()
	$('#stage').attr height: $(document).height()
	window.world = new fabric.Canvas('stage');

	grid = new Grid()

	window.creatures = []

	for [0...10]
		creature = new Creature()
		creatures.push creature
		world.add creature

	last_time = new Date().getTime()
	animate = (time) ->
		time ||= last_time
		dt = time - last_time

		for creature in creatures
			creature.update(dt)

		last_time = time

		world.renderAll()
		requestAnimationFrame animate

	animate()