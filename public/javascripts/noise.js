// importScripts('riffwave.js');

// var wave = new RIFFWAVE();
// wave.header.sampleRate = 22000;
// wave.header.numChannels = 1;
// wave.header.bitsPerSample = 16;
// var i = 0;
// var samples = [];

// while (i < 2000) {
//   while (i < 2000) {
//     samples[i++] = 0;
//     rand = 1 + Math.random() * 255;
//     samples[i++] = 0x8000+Math.round(0x7fff*Math.sin(i / rand));
//   }

//   wave.Make(samples);
//   self.postMessage(wave.dataURI);
// }

importScripts('wavencoder.js');

var sampleRateHz = 44100;
var numSamples = 0.4 * sampleRateHz;                 // 1 sec
var baseFreq = 2 * Math.PI * 27.5 / sampleRateHz;  // A0

var wavEncoder = new WavEncoder(numSamples, {sampleRateHz: sampleRateHz});

var prev_note = 0;

self.onmessage = function(event) {

  var samples = [];

  var note = (0.010 + Math.random() * 0.020) * 128;
  new_note = (prev_note + note) / 2;
  prev_note = note;
  var freq = baseFreq * new_note;
  for (var t = 0; t < numSamples; ++t) {
    // samples[t] = Math.sin(freq * t);
    s = (freq * t)
    samples[t] = s - Math.floor(s);
  }

  var tones = wavEncoder.encode(samples);
  // self.postMessage(tones);
}