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

	toInt: ->
		size = 0
		bits = _.chain(@rows)
			.flatten(@rows)
			.tap((rows) -> (size = rows.length - 1))
			.map((val, i) -> (if val then Math.pow(2, size - i) else 0))
			.reduce(((sum, val) -> (sum += val)), 0)
			.value()

	@fromInt: (val, w = 3, h = 6) ->
		num_bits = w * h
		num_bytes = Math.ceil(num_bits / 8)
		buffer = new Uint8Array(num_bytes)
		bitstream = new BitStream(buffer)
		bitstream.writeBits(num_bits, val)
		bitstream.seekTo(0)

		rows = []

		for y in [0...h]
			col = []
			rows.push col
			for x in [0...w]
				col.push(bitstream.readBits(1) == 1)

		new CreatureData(rows)


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
