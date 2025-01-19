for (var i = 0; i < 1000; i++) {
	var star =
	  '<div class="star m-0" style="animation: twinkle ' +
	  (Math.random() * 2 + 2) +  // Shorter time for faster appearance (from 5s to 2-4s)
	  's linear ' +
	  (Math.random() * 0.1) +  // Shorter delay for quicker start (from 1s to 0.5-1s)
	  's infinite; top: ' +
	  Math.random() * $(window).height() +
	  'px; left: ' +
	  Math.random() * $(window).width() +
	  'px;"></div>';
	$('.homescreen').append(star);
  }
  