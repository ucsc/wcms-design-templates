//
// Load Gulp and dependencies
//
const { src, dest, watch, series, parallel } = require('gulp');
// Importing all the Gulp-related packages we want to use
const sourcemaps = require('gulp-sourcemaps');
const sass = require('gulp-sass');
const concat = require('gulp-concat');
const uglify = require('gulp-uglify');
const postcss = require('gulp-postcss');
const autoprefixer = require('autoprefixer');
const cssnano = require('cssnano');
const gnd = require('gulp-npm-dist');
const del = require('del');
var replace = require('gulp-replace');
var pkg = require('./package.json');
    
sass.compiler = require('node-sass');
    

//
// Paths to source files
//
var files = {
    styles: 'src/sass/**/*.scss',
    scripts: './src/js/**/**',
    images:  './src/images/**/**',
    svg:     './src/svg/**/**.svg'
};

//
// Start a development server and serve files from dist
//



//
// Clean the build folder.
//
function clean(cb) {
  del.sync([
    'dist/**'
  ], cb());
}


//
// Compile sass into CSS and a source map.
//
function styles() {
  return src(files.styles)
    .pipe(sourcemaps.init())
    .pipe(sass())
    .pipe(postcss([ autoprefixer(), cssnano() ]))
    .pipe(sourcemaps.write('.'))
    .pipe(dest('dist')
  );
}


//
// Uglify scripts into the build folder.
//
function scripts() {
  return src([
    files.scripts
  ])
  .pipe(concat('main.js'))
  .pipe(uglify())
  .pipe(dest('dist')
  );  
}

//
// Copy dependencies from package.json to dist folder
// 
function libraries() {
  return src(gnd(), { base: './node_modules'})
    .pipe(dest('dist/libs')
  );
}

//
// Optimize and copy images into the build folder.
//
// gulp.task('images', function() {
//     return gulp.src(paths.images)
//         .pipe(changed('./build/_responsive/images/'))
//         .pipe(imagemin({
//             optimizationLevel: 5
//         }))
//         .pipe(gulp.dest('./build/_responsive/images/'));
// });


//
// Optimize SVG and make sprites in the build folder.
//
// gulp.task('svg', function() {
//     return gulp.src(paths.svg)
//         .pipe(svgo()())
//         .pipe(imacss('_svg.scss', 'icon'))
//         .pipe(gulp.dest('./src/sass/base'));
// });



//
// Copy old assets from previous design into the build folder.
//
// gulp.task('archive-files', function() {
//     return gulp.src('./src/archive/**')
//         .pipe(gulp.dest("./build"));
// });


//
// Create zip archive of static file assets ready for the WCMS.
//
// gulp.task('deploy', function() {
//     return gulp.src([
//             './build/**/**',
//             './examples/**/**'
//         ])
//         .pipe(zip('webtemplates2014.zip'))
//         .pipe(gulp.dest('./deploy'));
// });


//
// Rerun all tasks when files change
//
// gulp.task('watch', function() {
//     gulp.watch('./src/js/**/**', gulp.series('scripts'));
//     gulp.watch('./src/sass/**/*.scss', gulp.series('styles'));
//     gulp.watch('./src/images/**/.**', gulp.series('images'));
//     gulp.watch('./src/svg/**/**.svg', gulp.series('svg'));
// });
function watchFiles() {
  watch(files.styles, styles);
  watch(files.scripts, scripts);
}



exports.default = series(
  clean,
  parallel(styles, scripts),
  libraries
);
exports.watch = watchFiles;