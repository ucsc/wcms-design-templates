//
// Load Gulp and dependencies
//
var pkg = require('./package.json'),
    gulp = require('gulp'),
    assemble = require('assemble'),
    gulpAssemble = require('gulp-assemble'),
    browserSync = require('browser-sync'),
    changed = require('gulp-changed'),
    autoprefix = require('gulp-autoprefixer'),
    sass = require('gulp-ruby-sass'),
    concat = require('gulp-concat'),
    minifycss = require('gulp-minify-css'),
    clean = require('gulp-clean'),
    uglify = require('gulp-uglify'),
    prettify = require('gulp-html-prettify'),
    replace = require('gulp-replace'),
    imagemin = require('gulp-imagemin'),
    moment = require('moment'),
    mainBowerFiles = require('main-bower-files'),
    svgo = require('imagemin-svgo'),
    imacss = require('gulp-imacss'),
    zip = require('gulp-zip');



//
// Set default file path variables for tasks
//
var paths = {
    styles:     ['./src/sass/**.scss', './src/sass/**/**.**'],
    scripts:    './src/js/**/**',
    images:     './src/images/**/**',
    svg:        './src/svg/**/**.svg'
};


//
// Static webserver with livereload via Browsersync
//
gulp.task('webserver', function() {
    browserSync.init("./build/index.html", {
        server: {
            baseDir: "./build"            
        },
        watchOptions: {
            debounceDelay: 3000
        }
    });
});


//
// Clean the build folder so we start clean
//
gulp.task('clean', function() {
    gulp.src([
        'build/images',
        'build/css',
        'build/js'
        ], {
        read: false
    })
    .pipe(clean());
});


//
// Compile sass into CSS without source map.
//
gulp.task('styles', function() {
    return sass('src/sass', {
        require: ['bourbon', 'neat']
    }) 
    .on('error', function (err) {
      console.error('Error!', err.message);
   })
    .pipe(autoprefix('last 4 versions'))
    .pipe(minifycss())
    .pipe(gulp.dest('build/css'));
});


//
// Uglify scripts into the build folder.
//
gulp.task('scripts', function() {
    return gulp.src(paths.scripts)
        // Pass in options to the task
        .pipe(changed('./build/js/'))
        .pipe(uglify())
        .pipe(gulp.dest('./build/js/'));
});


//
// Optimize and copy images into the build folder.
//
gulp.task('images', function() {
    return gulp.src(paths.images)
        .pipe(changed('./build/images/'))
        .pipe(imagemin({
            optimizationLevel: 5
        }))
        .pipe(gulp.dest('./build/images/'));
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
        .pipe(gulp.dest("./build/lib"));
});


//
// Create zip archive of static file assets
//
gulp.task('deploy', function() {
    return gulp.src([
            './build/assets/css/**.**',
            './build/assets/images/**/**.**',
            './build/assets/js/**.**',
            './build/assets/lib/**/**.**'
        ], {
            base: "./build/assets"
        })
        .pipe(zip('_responsive.zip'))
        .pipe(gulp.dest('./deploy'));
});


//
// The default task (called when you run `gulp`)
//
gulp.task('default', ['bower-files', 'styles', 'scripts', 'images', 'svg', 'webserver'], function () {
    gulp.watch('src/js/**/**', ['scripts']);
    gulp.watch('src/sass/**/*.scss', ['styles']);
    gulp.watch('src/images/**/.**', ['images']);
    gulp.watch('src/svg/**/**.svg', ['svg']);
});


//
// The fresh task: compiles everything so we can zip it up for Cascade with 'gulp build'.
//
gulp.task('fresh', ['clean', 'bower-files', 'styles', 'scripts', 'images']);



