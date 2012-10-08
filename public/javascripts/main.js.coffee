$ ->
	$('#stage').attr width: $(document).width()
	$('#stage').attr height: $(document).height()
	stage = new fabric.Canvas('stage');

	grid = new Grid()

	creature = new Creature()
	stage.add creature

	last_time = new Date().getTime()
	animate = (time) ->

		dt = time - last_time

		if dt > 400
			last_time = time;
			creature.update()
			stage.renderAll()

		requestAnimationFrame animate

	animate()