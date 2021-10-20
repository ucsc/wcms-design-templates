
$(document).ready(function(){

  // "Enable" javascript by adding a body class.
  $('body').addClass('js');

  // Mobile mode if the screen width is below 768px
  var bodyWidth = $("body").innerWidth();
    if(bodyWidth <= 767) {
      $('.page-top-right').hide();
      $('#mainNav').hide();
    }

  // Logic to toggle mobile navigation
  var mobileNavOpen = 0; // Mobile nav closed by default
    
  $('.mobile-menu').click(function(){
    if (mobileNavOpen == 0){
      $('.page-top-right').slideDown(300);
      $('#mainNav').slideDown(300);
      $(this).addClass("active");
      mobileNavOpen = 1;
      return false;
    }
    else {
      $('.page-top-right').slideUp(300);
      $('#mainNav').slideUp(300);
      $(this).removeClass("active");
      mobileNavOpen = 0;
      return false;
    } 
  });


  // Additional tweaks
  var bodyWidth = $("body").innerWidth(); // No scrollbars

  //WINDOW RESIZE
    $(window).resize(function() {
      
      var bodyResize = $("body").innerWidth();
          
      //SHOW OR HIDE NAVS
      if ( (bodyResize <= 767) && mobileNavOpen == 0) {
        $('.page-top-right').hide();
        $('#mainNav').hide();
      } else {
        $('.page-top-right').show();
        $('#mainNav').show();
      }
      
    });

  /**
   * UI tweak: sidebar folders where all but the current page
   * are excluded from view still show an empty <ul>.
   * This adds a class to that <ul> that hides it.
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

  // Strip style attributes from main navigation.
  if (document.querySelectorAll('.main-navigation li a span')) {
    var navItems = document.querySelectorAll('.main-navigation li a span');
    for (var i = 0; i < navItems.length; i++) {
      navItems[i].removeAttribute("style");      
    }   
  }

  // Add flourish to flourish words
  if (document.querySelector('.secondary-name a')) {

  var text = document.querySelector('.secondary-name a').innerHTML.split(" ");
  var words = ["of", "and", "is", "&amp;"];

  for (var i = 0; i < text.length; i++) {
      for (var j = 0; j < words.length; j++) {
          if (text[i].toLowerCase() == words[j]) {
              text[i] = "<span class=\"flourish\">" + text[i] + "</span>";
          }
      }
  }

  var newHeading = text.join(' ');
  document.querySelector('.secondary-name a').innerHTML = newHeading;

}

});

// iFRAMES
function adjustIframes()
{
    $('iframe').each(function(){
        var
            $this       = $(this),
            proportion  = $this.data( 'proportion' ),
            w           = $this.attr('width'),
            actual_w    = $this.width();

        if ( ! proportion )
        {
            proportion = $this.attr('height') / w;
            $this.data( 'proportion', proportion );
        }

        if ( actual_w != w )
        {
            $this.css( 'height', Math.round( actual_w * proportion ) + 'px' );
        }
    });
}
$(window).on('resize load',adjustIframes);
