window.Creature = class Creature extends fabric.Group

	constructor: (options) ->

		super

		@frames = []

		frame = new CreatureFrame()
		@frames.push frame
		@frames.push frame.mutate(0.2).set(visible: false)

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

		@hasRotatingPoint = true
		@rotatingPointOffset

		@set fill: @randomColor()
		@set opacity: 0.7

	update: (dt) ->
		@time_since_toggle += dt
		@time_since_wander += dt

		if @time_since_wander > 2
			@time_since_wander = 0
			@ai.wander()
		@ai.update()

		if @time_since_toggle > 400
			@time_since_toggle = 0
			for frame in @frames
				frame.toggleVisible()

		@set left: @ai.position.x
		@set top: @ai.position.y
		@rotate(@ai.rotation + 90)

	randomColor: ->
		letters = '0123456789ABCDEF'.split('')
		color = '#'
		for [0...6]
			color += letters[Math.round(Math.random() * 15)]
		color
