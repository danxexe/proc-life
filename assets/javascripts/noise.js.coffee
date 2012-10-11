# importScripts('riffwave.js');

# var wave = new RIFFWAVE();
# wave.header.sampleRate = 22000;
# wave.header.numChannels = 1;
# wave.header.bitsPerSample = 16;
# var i = 0;
# var samples = [];

# while (i < 2000) {
  # while (i < 2000) {
    # samples[i++] = 0;
    # rand = 1 + Math.random() * 255;
    # samples[i++] = 0x8000+Math.round(0x7fff*Math.sin(i / rand));
  # }

  # wave.Make(samples);
  # self.postMessage(wave.dataURI);
# }

# importScripts('wavencoder.js')

# sampleRateHz = 44100
# numSamples = 0.4 * sampleRateHz
# baseFreq = 2 * Math.PI * 27.5 / sampleRateHz

# wavEncoder = new WavEncoder(numSamples, sampleRateHz: sampleRateHz)

# @onmessage = (e) ->

#   samples = []

#   note = 440

#   freq = baseFreq * note

#   for t in [0...numSamples]
#     s = (freq * t)
#     samples[t] = s - Math.floor(s);

#   tones = wavEncoder.encode(samples)
#   @postMessage(tones)

# console.log 'bla'