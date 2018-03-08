/* :::::::::::::::::::::::::::::::::::::::::::::::::::
  
  RESPONSIVE SCRIPTS
  
  :::::::::::::::::::::::::::::::::::::::::::::::::::*/
  $(document).ready(function() {

  // This is TERRIBLY kludgy, but we'll hide the
  // main nav and top row if the page width is 
  // below 768 on load.
  var bodyWidth = $("body").innerWidth();
  if(bodyWidth <= 767) {
    $('.page-top-right').hide();
    $('#mainNav').hide();
  }

  //MOBILE MENUS
  var mobileNavOpen = 0; //mobile nav closed
  
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
  
  var bodyWidth = $("body").innerWidth(); //no scrollbars

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