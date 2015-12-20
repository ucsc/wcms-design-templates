//
// Load Gulp and dependencies
//
var pkg = require('./package.json'),
    gulp = require('gulp'),
    autoprefix = require('gulp-autoprefixer'),
    browserSync = require('browser-sync'),
    changed = require('gulp-changed'),
    concat = require('gulp-concat'),
    del = require('del'),
    imacss = require('gulp-imacss'),
    imagemin = require('gulp-imagemin'),
    mainBowerFiles = require('main-bower-files'),
    minifycss = require('gulp-minify-css'),
    prettify = require('gulp-html-prettify'),
    sass = require('gulp-ruby-sass'),
    styleguide = require('sc5-styleguide'),
    sourcemaps = require('gulp-sourcemaps'),
    svgo = require('imagemin-svgo'),
    uglify = require('gulp-uglify'),
    zip = require('gulp-zip');



//
// Set default file path variables for tasks
//
var paths = {
    styles:     ['./src/sass/*.scss', './src/sass/**/**.**'],
    scripts:    './src/js/**/**',
    images:     './src/images/**/**',
    svg:        './src/svg/**/**.svg',
    build:      './build/'
};


//
// Static webserver with livereload via Browsersync
//
gulp.task('webserver', function() {
    browserSync.init("./build/index.html", {
        server: {
            baseDir: "./build/styleguide",
        },
        watchOptions: {
            debounceDelay: 3000
        },
        open: false,
        port: 8080
    });
});


//
// Clean the build folder.
//
gulp.task('clean', function(cb) {
    del.sync([
        'build/**'
    ], cb);
});


//
// Compile sass into CSS and a source map.
//
gulp.task('styles', function() {
    return sass('./src/sass/ucsc.scss', {
        require: ['bourbon', 'neat'],
        //style: 'compressed',
        sourcemap: true
    })
    .on('error', function (err) {
      console.error('Error: ', err.message);
   })
    .pipe(autoprefix('last 4 versions'))
    .pipe(sourcemaps.init())
    .pipe(styleguide.applyStyles())
    .pipe(gulp.dest('./build/styleguide'))
    .pipe(gulp.dest('./build/_responsive/css'));
});


//
// Uglify scripts into the build folder.
//
gulp.task('scripts', function() {
    return gulp.src(paths.scripts)
        .pipe(changed('./build/_responsive/js/'))
        .pipe(uglify())
        .pipe(gulp.dest('./build/_responsive/js/'));
});


//
// Optimize and copy images into the build folder.
//
gulp.task('images', function() {
    return gulp.src(paths.images)
        .pipe(changed('./build/_responsive/images/'))
        .pipe(imagemin({
            optimizationLevel: 5
        }))
        .pipe(gulp.dest('./build/_responsive/images/'));
});


//
// Optimize SVG and make sprites in the build folder.
//
gulp.task('svg', function() {
    return gulp.src(paths.svg)
        .pipe(svgo()())
        .pipe(imacss('_svg.scss', 'icon'))
        .pipe(gulp.dest('./src/sass/base'));
});


//
// Copy Bower assets into the build folder.
//
gulp.task('bower-files', function() {
    return gulp.src(mainBowerFiles(), {
            base: './bower_components'
        })
        .pipe(gulp.dest("./build/_responsive/lib"));
});


//
// Generate a styleguide from the style resources
//
gulp.task('styleguide', function() {
  return gulp.src('./src/sass/**/*.scss')
    .pipe(styleguide.generate({
        title: 'UC Santa Cruz web styleguide',
        server: true,
        rootPath: './build/styleguide',
        overviewPath: 'README.md'
      }))
    .pipe(gulp.dest('./build/styleguide'));
});


//
// Create zip archive of static file assets ready for the WCMS.
//
gulp.task('deploy', function() {
    return gulp.src([
            './build/_responsive/css',
            './build/_responsive/images',
            './build/_responsive/js',
            './build/_responsive/lib'
        ], {
            base: "./build/_responsive"
        })
        .pipe(zip('_responsive.zip'))
        .pipe(gulp.dest('./deploy'));
});


//
// Rerun all tasks when files change
//
gulp.task('watch', function() {
    gulp.watch('./src/js/**/**', ['scripts']);
    gulp.watch('./src/sass/**/*.scss', ['styles', 'styleguide']);
    gulp.watch('./src/images/**/.**', ['images']);
    gulp.watch('./src/svg/**/**.svg', ['svg']);
});


//
// The default task (called when you run `gulp`)
//
gulp.task('default', ['clean', 'watch', 'bower-files', 'scripts', 'images', 'svg', 'styles', 'styleguide', 'webserver']);

//
// The fresh task: compiles everything so we can zip it up for Cascade with 'gulp build'.
//
gulp.task('fresh', ['clean', 'bower-files', 'scripts', 'images', 'svg', 'styles']);