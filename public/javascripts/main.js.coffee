$ ->
	$('#stage').attr width: $(document).width()
	$('#stage').attr height: $(document).height()
	window.world = new fabric.Canvas('stage');

	grid = new Grid()

	world.creatures = creatures = []

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

		selected_creature?.update(dt, ai: false)

		playNote(dt)

		last_time = time

		world.renderAll()
		requestAnimationFrame animate

	animate()

	window.selected_creature = null
	world.on 'object:selected', (options) ->
		world.remove selected_creature

		creature = options.target

		window.selected_creature = new Creature(creature)

		selected_creature.top = selected_creature.height + 8
		selected_creature.left = selected_creature.width + 8

		selected_creature.scale 2
		selected_creature.set
			fill: creature.fill

		world.add selected_creature

	world.on 'selection:created', (options) ->
		world.discardActiveGroup()
		creature = options.target.objects[0]
		world.fire('object:selected', target: creature)
