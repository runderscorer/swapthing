window.onload = function() {
  var clicks = 0;

  document.querySelector('.nav-logo').addEventListener('click', function() {
    clicks += 1;
    if (clicks === 1) { console.log('Swap') }
    if (clicks === 2) { console.log('Thing') }
    if (clicks === 7) { console.log('you make my heart sing')}
  });
};