window.Creature = class Creature extends fabric.Group

	constructor: (options) ->

		super

		@frames = []

		frame = new CreatureFrame()
		@frames.push frame
		@frames.push frame.mutate(0.2).set(visible: false)

		@time_since_update = 0

		for frame in @frames
			@add frame

	update: (dt) ->
		@time_since_update += dt
		if @time_since_update > 400
			@time_since_update = 0
			for frame in @frames
				frame.toggleVisible()
