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

$(document).ready(function(){
  
  // "Enable" javascript by adding a body class. 
  $('body').addClass('js');

  // Remove default value from search input on focus.
  $('input.query').each( function(index){
    var el = $(this);
    var def = el.attr('value');

      el.val(def).focus(function() {
        if(el.val() == def) {
          el.val("");
        }
        el.blur(function() {
          if(el.val() == "") {
            el.val(def);
          }
        });
      });
  });

/**
    UI tweak: sidebar folders where all but the current page
    are excluded from view still show an empty <ul>.
    This adds a class to that <ul> that hides it.
 */
$('.sidebar li > ul').each(function() {
    var $this = $(this);
    var $lis = $this.find('li');

    if ($lis.length === 0) return;

    if ($lis.filter('.excluded').length === $lis.length) {
        $this.hide();
    } else {
        return;
    }
});

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
  
  $('ul#mainNav li').click(function(e){
    $(this).children('ul').slideToggle();
    e.stopPropagation();
  });
  
  
});

$(window).load(function() {

/**
 * UI-tweak: This looks at the natural width of article/profile
 * images and sets a class on the parent <figure> element to
 * establish the maximum width of the figure, which prevents
 * the image from stretching too much.
 *
 * Called with the window.load event to ensure
 * all images have loaded.
 */
$(".article-image img").each(function() { 
  if(this.naturalWidth > 580) {
    $(this).parent().addClass("width-full");
  } else if(this.naturalWidth > 480) {
      $(this).parent().addClass("width-580");
  } else if(this.naturalWidth > 350) {
      $(this).parent().addClass("width-480");
  } else if(this.naturalWidth > 280) {
      $(this).parent().addClass("width-350");
  } else if(this.naturalWidth > 180) {
      $(this).parent().addClass("width-280");
  } else if(this.naturalWidth > 110) {
      $(this).parent().addClass("width-180");
  } else {
      $(this).parent().addClass("width-110");
  }
});


});


/*
 * jQuery dropdown: A simple dropdown plugin
 *
 * Copyright 2013 Cory LaViska for A Beautiful Site, LLC. (http://abeautifulsite.net/)
 *
 * Licensed under the MIT license: http://opensource.org/licenses/MIT
 *
*/jQuery&&function(e){function t(t,i){var s=t?e(this):i,o=e(s.attr("data-dropdown")),u=s.hasClass("dropdown-open");if(t){if(e(t.target).hasClass("dropdown-ignore"))return;t.preventDefault();t.stopPropagation()}else if(s!==i.target&&e(i.target).hasClass("dropdown-ignore"))return;n();if(u||s.hasClass("dropdown-disabled"))return;s.addClass("dropdown-open");o.data("dropdown-trigger",s).show();r();o.trigger("show",{dropdown:o,trigger:s})}function n(t){var n=t?e(t.target).parents().addBack():null;if(n&&n.is(".dropdown")){if(!n.is(".dropdown-menu"))return;if(!n.is("A"))return}e(document).find(".dropdown:visible").each(function(){var t=e(this);t.hide().removeData("dropdown-trigger").trigger("hide",{dropdown:t})});e(document).find(".dropdown-open").removeClass("dropdown-open")}function r(){var t=e(".dropdown:visible").eq(0),n=t.data("dropdown-trigger"),r=n?parseInt(n.attr("data-horizontal-offset")||0,10):null,i=n?parseInt(n.attr("data-vertical-offset")||0,10):null;if(t.length===0||!n)return;t.hasClass("dropdown-relative")?t.css({left:t.hasClass("dropdown-anchor-right")?n.position().left-(t.outerWidth(!0)-n.outerWidth(!0))-parseInt(n.css("margin-right"),10)+r:n.position().left+parseInt(n.css("margin-left"),10)+r,top:n.position().top+n.outerHeight(!0)-parseInt(n.css("margin-top"),10)+i}):t.css({left:t.hasClass("dropdown-anchor-right")?n.offset().left-(t.outerWidth()-n.outerWidth())+r:n.offset().left+r,top:n.offset().top+n.outerHeight()+i})}e.extend(e.fn,{dropdown:function(r,i){switch(r){case"show":t(null,e(this));return e(this);case"hide":n();return e(this);case"attach":return e(this).attr("data-dropdown",i);case"detach":n();return e(this).removeAttr("data-dropdown");case"disable":return e(this).addClass("dropdown-disabled");case"enable":n();return e(this).removeClass("dropdown-disabled")}}});e(document).on("click.dropdown","[data-dropdown]",t);e(document).on("click.dropdown",n);e(window).on("resize",r)}(jQuery);



