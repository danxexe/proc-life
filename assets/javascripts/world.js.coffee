window.World = class World extends fabric.Canvas

	constructor: (options) ->
		super

		@creatures = []

	setup: ->
		for creature in @creatures
			@add creature

		@last_time = new Date().getTime()

		window.selected_creature = null

		world =  @
		@on 'object:over', (options) ->
			world.remove selected_creature

			creature = options.target
			world.setActiveObject(creature)

			window.selected_creature = new Creature(creature)

			selected_creature.top = selected_creature.height + 8
			selected_creature.left = selected_creature.width + 8

			selected_creature.scale 2

			world.add selected_creature

	generateCreatures: (count) ->
		for [0...count]
			creature = new Creature()
			@creatures.push creature

	animate: (time) ->
		time ||= @last_time
		dt = time - @last_time

		for creature in @creatures
			creature.update(dt)

		selected_creature?.update(dt, ai: false)

		# playNote(dt)

		@last_time = time

		@renderAll()