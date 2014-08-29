jQuery(document).ready(function() {
      var owl = jQuery("#slides");
      owl.owlCarousel({
        autoPlay : 5000,
        stopOnHover : true,
        navigation: true,
        paginationSpeed : 1000,
        goToFirstSpeed : 2000,
        singleItem : true,
        autoHeight : true,
        lazyLoad : true,
        transitionStyle: "fade"
      });
      
    });