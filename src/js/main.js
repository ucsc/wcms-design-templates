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

});



$(window).load(function() {

  /**
   * UI-tweak: This looks at the natural width of article/profile
   * images and sets the width of the parent <figure> element to
   * x+16 to match the width of the image.
   *
   * Called with the window.load event to ensure
   * all images have loaded.
   */
  $(".article-image img").each(function() {

    var newWidth = this.naturalWidth + 16;
    $(this).parent().css({"width": newWidth});

  });

});