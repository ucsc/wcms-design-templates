let mix = require('laravel-mix');


// Compile SASS to CSS
mix.sass('src/sass/ucsc.scss', 'dist/css', {
    processUrls: false,
    sassOptions: {
        outputStyle: 'compressed'
    }
});

// Copy javascript libraries to distribution folder
mix.copyDirectory('node_modules/owlcarousel/owl-carousel', 'dist/lib/owlcarousel/owl-carousel');
mix.copyDirectory('node_modules/fancybox/dist', 'dist/lib/fancybox/source');
mix.copy('node_modules/jquery/dist/jquery.js', 'dist/lib/jquery/dist/jquery.js');

// Copy images to distribution folder
mix.copyDirectory('src/js', 'dist/js');
mix.minify('dist/js/*.js', 'bundle.js');

// Copy images to distribution folder
mix.copyDirectory('src/images', 'dist/images');

