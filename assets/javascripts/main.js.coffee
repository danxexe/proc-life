$ ->
	$('#stage').attr width: $(document).width()
	$('#stage').attr height: $(document).height()
	window.world = world = new World('stage')

	num_creatures = url('#creatures') || 10
	bg_color = url('#bg') || '#fff'
	scale = url('#scale') || 1

	world.backgroundColor = bg_color
	world.scale = scale
	world.generateCreatures(num_creatures)
	world.run()

	# Select last created creature:
	# world.fire 'object:over', target: world.creatures[world.creatures.length - 1]

	# Crature from serialized string:
	# c = CreatureSerializer.fromString('GLxkrzA7E5E=')

	# Serialize a creature:
	# console.log CreatureSerializer.toString(c)

	# Create a new creature and add to world
	# c = new Creature();
	# world.creatures.push c
