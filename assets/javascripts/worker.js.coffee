# worker = new Worker('javascripts/noise.js')

# worker.addEventListener 'message', (e) ->
#   audio = new Audio(e.data)
#   audio.addEventListener 'ended', ->
#     worker.postMessage()

#   audio.play()
# , false

# worker.postMessage()

audio = new webkitAudioContext()
window.synth = audio.createOscillator()
synth.type = 2 # Sawtooth

time_since_note = 0
window.mute = false

$(window).keydown (e) ->
	if e.which == 77
		window.mute = !window.mute
		synth.noteOff(0) if window.mute
		console.log window.mute

window.playNote = (dt) ->
	return if window.mute

	time_since_note += dt

	if time_since_note > 400
		note = Math.floor(-12 + Math.random() * 12)
		freq = Math.pow(2, note / 12) * 440
		synth.frequency.value = freq
		synth.connect(audio.destination)
		synth.noteOn(0)
		synth.noteOff(10)

	if time_since_note > 600
		time_since_note = 0
		synth.disconnect()

	time_since_note