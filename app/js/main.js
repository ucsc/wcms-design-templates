$(document).ready(function(){

 //  $(".menu").click(function() {
 //  	$( "#nav" ).slideToggle(300);
 //  	event.preventDefault();
	// });
	
	$('.nav-toggle').bind('click focus', function(){event.preventDefault();$('#mainNav').toggleClass('collapsed')});

});