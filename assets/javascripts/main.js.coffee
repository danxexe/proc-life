$ ->
	$('#stage').attr width: $(document).width()
	$('#stage').attr height: $(document).height()
	window.world = world = new World('stage')
	world.selection = false

	app_animate = () ->
		world.animate(new Date().getTime())
		requestAnimationFrame app_animate

	# CreatureSerializer.toString(selected_creature)

	# c = CreatureSerializer.fromString('GLxkrzA7E5E=')
	# console.log c
	# console.log CreatureSerializer.toString(c)

	# c = new Creature();

	# world.creatures.push c
	world.generateCreatures(10)
	world.setup()
	# world.fire 'object:over', target: world.creatures[world.creatures.length - 1]

	app_animate()