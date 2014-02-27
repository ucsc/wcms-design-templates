$(document).ready(function(){

 //  $(".menu").click(function() {
 //  	$( "#nav" ).slideToggle(300);
 //  	event.preventDefault();
	// });
	
	$('.toggle-nav').bind('click focus', function(){event.preventDefault();$('#mainNav').toggleClass('collapsed')});

});