var worker = new Worker('javascripts/noise.js');

worker.addEventListener('message', function(e) {
  var audio = new Audio(e.data);
  audio.addEventListener('ended', function() {
    worker.postMessage();
  });
  audio.play();
}, false);

worker.postMessage();