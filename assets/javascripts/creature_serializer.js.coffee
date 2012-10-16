window.CreatureSerializer = class CreatureSerializer

	# constructor: (options) ->

	@toString: (creature) ->
		return 'CreatureSerializer' unless creature

		# We are assuming a 6 * 3 data matrix

		num_bytes = Math.ceil((18 * creature.frames.length + 24) / 8)
		buffer = new Uint8Array(num_bytes)
		bitstream = new BitStream(buffer)

		# frames
		for frame in creature.frames
			bitstream.writeBits(18, frame.data.toInt())

		# padding
		bitstream.writeBits(bitstream.bitsPending, 0)

		# color
		bitstream.writeBits(24, creature.fillToInt())

		Base64.fromByteArray(buffer)

	@fromString: (string, num_frames = 2) ->
		buffer = Base64.toByteArray(string)
		bitstream = new BitStream(buffer)

		# frames
		frames = []
		frames.push bitstream.readBits(18) for [0...num_frames]
		frames = _.map(frames, (frame) -> CreatureData.fromInt(frame))

		# padding
		bitstream.readBits(bitstream.bitsPending)

		# color
		color = '#' + bitstream.readBits(24).toString(16)

		creature = new Creature(frames: frames, fill: color)
