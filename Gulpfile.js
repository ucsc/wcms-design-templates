var pkg = require('./package.json'),
    gulp = require('gulp'),
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
    zip = require('gulp-zip'),
    svgo = require('imagemin-svgo'),
    sprites = require('gulp-svg-sprites'),
    imacss = require('gulp-imacss'),
    browserSync = require('browser-sync');


//
// Set default file path variables for tasks
//
var paths = {
    styles: ['./app/src/sass/*.scss', './app/src/sass/**/**.**'],
    scripts: './app/src/js/**/**',
    images: './app/src/images/**/**',
    svg: './app/src/svg/**/**.svg',
    fonts: './app/src/fonts/*'
};


//
// Static webserver with livereload via connect
//
// gulp.task('webserver', function() {
//     connect.server({
//         livereload: true,
//         root: ['./app/serve']
//     });
// });
gulp.task('webserver', function() {
    browserSync.init("./app/serve/index.html", {
        server: {
            baseDir: "./app/serve"            
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
        'app/src/jekyll/images',
        'app/src/jekyll/css',
        'app/src/jekyll/js'
        ], {
        read: false
    })
    .pipe(clean());
});


//
// Compile sass into CSS without source map.
//
gulp.task('styles', function() {
    return gulp.src(paths.styles)
        .pipe(changed('./app/src/jekyll/css/'))
        .pipe(sass({
            sourcemap: false,
            sourcemapPath: '.',
            require: ['bourbon', 'neat']
        }))
        .pipe(autoprefix('last 4 versions'))
        .pipe(minifycss())
        .pipe(gulp.dest('./app/src/jekyll/css/'));
});


//
// Uglify scripts into the build folder.
//
gulp.task('scripts', function() {
    return gulp.src(paths.scripts)
        // Pass in options to the task
        .pipe(changed('./app/src/jekyll/js/'))
        .pipe(uglify())
        .pipe(gulp.dest('./app/src/jekyll/js/'));
});


//
// Optimize and copy images into the build folder.
//
gulp.task('images', function() {
    return gulp.src(paths.images)
        .pipe(changed('./app/src/jekyll/images/'))
        .pipe(imagemin({
            optimizationLevel: 5
        }))
        .pipe(gulp.dest('./app/src/jekyll/images/'));
});


//
// Optimize svg and make sprites in the build folder.
//
gulp.task('svg', function() {
    return gulp.src(paths.svg)
        .pipe(svgo()())
        .pipe(imacss('_svg.scss', 'icon'))
        .pipe(gulp.dest('./app/src/sass/base'));
});


//
// Gulp task to run Jekyll
// 
gulp.task('jekyll', function (gulpCallBack) {

    var spawn = require('child_process').spawn;
    var jekyll = spawn('jekyll', ['build'], {stdio: 'inherit'});

    jekyll.on('exit', function(code) {
        gulpCallBack(code === 0 ? null : 'ERROR: Jekyll process exited with code: '+code);
    });

});


//
// Copy Bower assets into the build folder.
//
gulp.task('bower-files', function() {
    return gulp.src(mainBowerFiles(), {
            base: './bower_components'
        })
        .pipe(gulp.dest("./app/jekyll/lib"));
});


//
// Create zip archive of static file assets
//
gulp.task('build', function() {
    return gulp.src([
            './app/src/jekyll/css/**.**',
            './app/src/jekyll/images/**/**.**',
            './app/src/jekyll/js/**.**',
            './app/src/jekyll/lib/**/**.**'
        ], {
            base: "./app/src/jekyll"
        })
        .pipe(zip('_responsive.zip'))
        .pipe(gulp.dest('./static'));
});


//
// The default task (called when you run `gulp`)
//
gulp.task('default', ['bower-files', 'styles', 'scripts', 'images', 'svg', 'jekyll', 'webserver'], function () {
    gulp.watch('app/src/js/**/**', ['scripts']);
    gulp.watch('app/src/sass/**/*.scss', ['styles']);
    gulp.watch('app/src/images/**/.**', ['images']);
    gulp.watch('app/src/svg/**/**.svg', ['svg']);
    gulp.watch('app/src/jekyll/**/**', ['jekyll']);
});


//
// The fresh task: compiles everything so we can zip it up for Cascade with 'gulp build'.
//
gulp.task('fresh', ['clean', 'bower-files', 'styles', 'scripts', 'images']);



