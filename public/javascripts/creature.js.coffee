window.Creature = class Creature extends fabric.Group

	constructor: (options) ->

		super

		@frames = []

		frame = new CreatureFrame()
		@frames.push frame
		@frames.push frame.mutate(0.2).set(visible: false)

		for frame in @frames
			@add frame

	update: ->
		for frame in @frames
			frame.toggleVisible()
