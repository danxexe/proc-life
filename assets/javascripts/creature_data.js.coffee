window.CreatureData = class CreatureData

	constructor: (w_or_data = 1, h = 1) ->
		if w_or_data instanceof Array
			@rows = w_or_data
			@h = @rows.length
			@w = @rows[0].length
		else if w_or_data instanceof CreatureData
			@rows = w_or_data.rows
			@h = @rows.length
			@w = @rows[0].length
		else
			@w = w_or_data
			@h = h
			@rows = CreatureData.matrix(@w, @h)

	mutate: (chance) ->
		new_data = []
		for row, y in @rows
			new_row = []
			new_data.push new_row
			for p, x in row
				new_p = CreatureData.pixel(p, chance)
				new_row.push new_p
		new CreatureData(new_data)

	@matrix: (w, h) ->
		matrix = []
		for y in [0...h]
			matrix.push @matrix_row(w)
		matrix

	@matrix_row: (w) ->
		row = []
		for x in [0...w]
			row.push @pixel()
		row

	@pixel: (current = false, chance = 0.5) ->
		flipped = Math.floor(Math.random() * (1 / chance)) == 1
		if flipped then !current else current

	toBinaryString: ->
		string = ''
		for row in @rows
			for p in row
				string += (if p then '1' else '0')
		string

	toInt: ->
		parseInt(@toBinaryString(), 2)

	toByteArray: ->
		bytes = []
		value = @toInt()
		for k in [2..0]
			bytes[k] = value & (255)
			value = value / 256
		bytes

	toBase64: ->
		Base64.fromByteArray @toByteArray()
