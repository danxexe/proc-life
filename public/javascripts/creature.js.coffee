window.Creature = class Creature extends fabric.Group

	constructor: (options) ->
		@frames = []

		frame = null
		if options instanceof Creature
			frame = options.frames[0]
			for f in options.frames
				@frames.push new CreatureFrame(f.data)
			@frames[1].set(visible: false)
			options = null
		else
			frame = new CreatureFrame()
			@frames.push frame
			@frames.push frame.mutate(0.2).set(visible: false)

		super

		@set width: frame.width
		@set height: frame.height

		@time_since_toggle = 0
		@time_since_wander = 0

		for frame in @frames
			@add frame

		@ai = new SteeredVehicle()
		@ai.maxSpeed = 0.5 + Math.random() * 3
		@ai.maxForce = 1 + Math.random() * 0.3
		# @ai.velocity = new Vector2D(5+Math.random()*10,5+Math.random()*10)
		@ai.position = new Vector2D(world.width / 2,  world.height / 2)
		@ai.wanderAngle = 45
		@ai.bounds = { x:0, y:0, width: world.width, height: world.height }
		# @ai.edgeBehavior = "BOUNCE"

		@set top: world.height / 2
		@set left: world.width / 2

		@hasRotatingPoint = true
		@rotatingPointOffset

		@set fill: @randomColor()
		@set opacity: 0.7

		@set cornersize: 5

	update: (dt, options = {}) ->
		@time_since_toggle += dt
		@time_since_wander += dt

		unless options['ai'] == false
			if @time_since_wander > 2
				@time_since_wander = 0
				@ai.wander()

			@ai.update()

			@set left: @ai.position.x
			@set top: @ai.position.y
			@rotate(@ai.rotation + 90)

		if @time_since_toggle > 400
			@time_since_toggle = 0
			for frame in @frames
				frame.toggleVisible()

	randomColor: ->
		letters = '0123456789ABCDEF'.split('')
		color = '#'
		for [0...6]
			color += letters[Math.round(Math.random() * 15)]
		color
