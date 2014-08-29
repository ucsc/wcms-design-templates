$(document).ready(function() {
    //Sort random function
    function random(owlSelector){
        owlSelector.children().sort(function(){
            return Math.round(Math.random()) - 0.5;
        }).each(function(){
            $(this).appendTo(owlSelector);
        });
    }

    //Set slide location
    $owl = $("#slides");
    $owlSlides = $owl.children('div');

    //Check for single slide
    if($owlSlides.length > 1) {
        //Set carousel
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
        //Stop carousel on page click
        $(".owl-page").click(function(){
            $owl.trigger('owl.stop');
        });
    } else {
        //Remove carousel class
        $owl.removeClass( "owl-carousel" );
    }
});