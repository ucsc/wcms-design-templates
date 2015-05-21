// Universal Analytics snippet - 21 May 2015
(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
})(window,document,'script','//www.google-analytics.com/analytics.js','ga');

ga('create', 'UA-4301164-1', 'auto', {'autoLinker': true});
ga('require', 'linker');
ga('linker:autoLink', ['imodules.com']);
ga('send', 'pageview');


// Event tracking calls (jQuery required for DOM selection)
$(function() {

	// Default link tracking
	$('a[href]').each(function() {

		var currPageTitle = document.title; // Page title
		var currPagePath = window.location.pathname; // URL path
		var linkURL = $(this).attr('href'); // Hyperlink URL
		var linkText = $(this).text(); // Hyperlink text

		// Outbound link
		if ( linkURL.match(/^https?\:/i) && (!linkURL.match(document.domain)) ) {
			$(this).click(function() {
				var outboundURL = linkURL.replace(/^https?\:\/\//i, ''); // Outbound URL without http(s)
				ga('send', 'event', 'Link', 'Click', linkText + ' (' + outboundURL + ')', {'nonInteraction': 1});
			});
		}
		// Email link
		if ( linkURL.match(/^mailto\:/i) ) {
			$(this).click(function() {
				var emailAddress = linkURL.replace(/^mailto\:/i, ''); // Email link without mailto:
				ga('send', 'event', 'Link', 'Click - email', linkText + ' (' + emailAddress + ')', {'nonInteraction': 1});
			});
		}
		// Download link
		if ( linkURL.match(/\.(zip|pdf|doc*|xls*|ppt*|mp3)$/i) ) {
			$(this).click(function() {
				var docExtension = linkURL.slice(linkURL.lastIndexOf(".") +1);
				var docPath = linkURL.replace(/^https?\:\/\/(www.)ucsc\.edu\//i, ''); // Document file path
				ga('send', 'event', 'Link', 'Click - ' + docExtension, linkText + ' (' + docPath + ')', {'nonInteraction': 1});
			});
		}

	});


});
