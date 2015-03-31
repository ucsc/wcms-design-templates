$(document).ready(function() {
    
    // Sort random function
    function random(owlSelector){
      if ($("#slides").hasClass("random")) {
        // Tell me you're doing this.
        console.log("Randomizing slides...");
        // Now do it.
        owlSelector.children().sort(function(){
            return Math.round(Math.random()) - 0.5;
        }).each(function(){
            $(this).appendTo(owlSelector);
        });
      } else {
        console.log("Not randomizing slides...");
        return;
      }  
    }

    // Set slide location
    $owl = $("#slides");
    $owlSlides = $owl.children('div');

    // How many slides?
    console.log("You have " + $owlSlides.length + " slides.");

    // Check for single slide    
    if($owlSlides.length > 1) {
      console.log("Slider initialized.");
        // Set carousel
        $owl.owlCarousel({
            autoPlay : 5000,
            stopOnHover : true,
            navigation:true,
            paginationSpeed : 1000,
            goToFirstSpeed : 2000,
            singleItem : true,
            autoHeight : true,
            lazyLoad : true,
            transitionStyle:"fade",
            beforeInit : function(elem){
                random(elem);
            }
        });
        // Stop carousel on page click
        $(".owl-page").click(function(){
            $owl.trigger('owl.stop');
        });
    } else {
        // Remove carousel class
        $owl.removeClass( "owl-carousel" );
    }
});