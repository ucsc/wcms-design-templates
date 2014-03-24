/*
// DROPDOWN MENU
function dropDownMenu() {
	
	var dropdownLinks = $(".dropdown-link");
	var dropdownWrapper = $(this).next(".dropdown-wrapper");
	var dropdownSpacer = $("#dropdown-spacer");
	
	//if all dropdown menus are closed
	if ( !($(dropdownLinks).hasClass("selected")) ) {
		$(this).addClass("selected");
		$(dropdownSpacer).animate({
			height: "115"
		}, "fast");
		$(dropdownWrapper).slideDown("fast");
	} 
	//if $(this) dropdown menu is open
	else if ( $(this).hasClass("selected") ) { 
		$(this).removeClass("selected");
		$(dropdownSpacer).animate({
			height: "0"
		}, "fast");
		$(dropdownWrapper).slideUp("fast");
	} 
	//if another dropdown menu is open
	else if ( $(dropdownLinks).not(this).hasClass("selected") ) { 
		$(dropdownLinks).removeClass("selected");
		$(this).addClass("selected");
		$(".dropdown-wrapper").hide();
		$(dropdownWrapper).show();
	}
	
	//don't follow the link
	return false;
}
*/
// DOM
$(document).ready(function(){
	//BODY
	$('body').addClass('js');
	/*
	// MAIN NAV
	$(".dropdown-link").bind("click",dropDownMenu); //bind dropdown menu function

	$(".close").click(function(){ //close menu
		$('.selected').focus();
		$(".dropdown-link").removeClass('selected');		
		$(this).parents(".dropdown-wrapper").slideUp("fast");
		$("#dropdown-spacer").animate({
    		height: ""
 		}, "fast");
	
 		return false;
	});
	*/
});

/*
 * jQuery dropdown: A simple dropdown plugin
 *
 * Copyright 2013 Cory LaViska for A Beautiful Site, LLC. (http://abeautifulsite.net/)
 *
 * Licensed under the MIT license: http://opensource.org/licenses/MIT
 *
*/jQuery&&function(e){function t(t,i){var s=t?e(this):i,o=e(s.attr("data-dropdown")),u=s.hasClass("dropdown-open");if(t){if(e(t.target).hasClass("dropdown-ignore"))return;t.preventDefault();t.stopPropagation()}else if(s!==i.target&&e(i.target).hasClass("dropdown-ignore"))return;n();if(u||s.hasClass("dropdown-disabled"))return;s.addClass("dropdown-open");o.data("dropdown-trigger",s).show();r();o.trigger("show",{dropdown:o,trigger:s})}function n(t){var n=t?e(t.target).parents().addBack():null;if(n&&n.is(".dropdown")){if(!n.is(".dropdown-menu"))return;if(!n.is("A"))return}e(document).find(".dropdown:visible").each(function(){var t=e(this);t.hide().removeData("dropdown-trigger").trigger("hide",{dropdown:t})});e(document).find(".dropdown-open").removeClass("dropdown-open")}function r(){var t=e(".dropdown:visible").eq(0),n=t.data("dropdown-trigger"),r=n?parseInt(n.attr("data-horizontal-offset")||0,10):null,i=n?parseInt(n.attr("data-vertical-offset")||0,10):null;if(t.length===0||!n)return;t.hasClass("dropdown-relative")?t.css({left:t.hasClass("dropdown-anchor-right")?n.position().left-(t.outerWidth(!0)-n.outerWidth(!0))-parseInt(n.css("margin-right"),10)+r:n.position().left+parseInt(n.css("margin-left"),10)+r,top:n.position().top+n.outerHeight(!0)-parseInt(n.css("margin-top"),10)+i}):t.css({left:t.hasClass("dropdown-anchor-right")?n.offset().left-(t.outerWidth()-n.outerWidth())+r:n.offset().left+r,top:n.offset().top+n.outerHeight()+i})}e.extend(e.fn,{dropdown:function(r,i){switch(r){case"show":t(null,e(this));return e(this);case"hide":n();return e(this);case"attach":return e(this).attr("data-dropdown",i);case"detach":n();return e(this).removeAttr("data-dropdown");case"disable":return e(this).addClass("dropdown-disabled");case"enable":n();return e(this).removeClass("dropdown-disabled")}}});e(document).on("click.dropdown","[data-dropdown]",t);e(document).on("click.dropdown",n);e(window).on("resize",r)}(jQuery);



