$ ->
	$('#stage').attr width: $(document).width()
	$('#stage').attr height: $(document).height()
	stage = new fabric.Canvas('stage');

	grid = new Grid()

	window.creature = new Creature()
	stage.add creature

	last_time = new Date().getTime()
	animate = (time) ->
		time ||= last_time
		dt = time - last_time

		creature.update(dt)

		last_time = time

		stage.renderAll()
		requestAnimationFrame animate

	animate()