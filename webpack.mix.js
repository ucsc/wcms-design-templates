let mix = require("laravel-mix");

// Compile SASS to CSS
mix.sass("src/sass/ucsc.scss", "assets/css", {
  processUrls: false,
  sassOptions: {
    outputStyle: "compressed",
  },
});

// Copy javascript libraries to distribution folder
mix.copyDirectory(
  "node_modules/owlcarousel/owl-carousel",
  "assets/lib/owlcarousel/owl-carousel"
);
mix.copyDirectory("node_modules/fancybox/dist", "assets/lib/fancybox/source");
mix.copy(
  "node_modules/jquery/dist/jquery.js",
  "assets/lib/jquery/dist/jquery.js"
);

// Copy images to distribution folder
mix.copyDirectory("src/js", "assets/js");
mix.minify("assets/js/*.js", "bundle.js");

// Copy images to distribution folder
mix.copyDirectory("src/images", "assets/images");

// mix.browserSync({
//     server: "./dist"
// });
