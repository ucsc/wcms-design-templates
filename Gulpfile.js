var pkg = require('./package.json'),
    gulp = require('gulp'),
    changed = require('gulp-changed'),
    autoprefix = require('gulp-autoprefixer'),
    sass = require('gulp-ruby-sass'),
    concat = require('gulp-concat'),
    minifycss = require('gulp-minify-css'),
    clean = require('gulp-clean'),
    uglify = require('gulp-uglify'),
    refresh = require('gulp-livereload'),
    assemble = require('gulp-assemble'),
    prettify = require('gulp-html-prettify'),
    replace = require('gulp-replace'),
    imagemin = require('gulp-imagemin'),
    moment = require('moment'),
    mainBowerFiles = require('main-bower-files'),
    zip = require('gulp-zip'),
    svgo = require('imagemin-svgo'),
    sprites = require('gulp-svg-sprites'),
    imacss = require('gulp-imacss'),
    exec = require('child_process').exec,
    connect = require('gulp-connect');


//
// Set default file path variables for tasks
//
var paths = {
    styles: ['./app/sass/*.scss', './app/sass/**/**.**'],
    scripts: './app/js/**/**',
    images: './app/images/**',
    svg: './app/svg/**/**.svg',
    fonts: './app/fonts/*'
};


//
// Static webserver with livereload via connect
//
gulp.task('webserver', function() {
    connect.server({
        livereload: true,
        root: ['./app/_site']
    });
});


//
// Clean the build folder so we start clean
//
gulp.task('clean', function() {
    gulp.src(['app/build/images', 'app/build/css', 'app/build/js', 'app/build/*.html'], {
        read: false
    })
        .pipe(clean());
});


//
// Compile sass into CSS without source map.
//
gulp.task('styles', function() {
    return gulp.src(paths.styles)
        .pipe(changed('./app/build/css/'))
        .pipe(sass({
            sourcemap: false,
            sourcemapPath: '.',
            require: ['bourbon', 'neat']
        }))
        .pipe(autoprefix('last 4 versions'))
        .pipe(minifycss())
        .pipe(gulp.dest('./app/jekyll/css/'))
        .pipe(connect.reload());
});


//
// Uglify scripts into the build folder.
//
gulp.task('scripts', function() {
    return gulp.src(paths.scripts)
        // Pass in options to the task
        .pipe(changed('./app/jekyll/js/'))
        .pipe(uglify())
        .pipe(gulp.dest('./app/jekyll/js/'))
        .pipe(connect.reload());
});


//
// Optimize and copy images into the build folder.
//
gulp.task('images', function() {
    return gulp.src(paths.images)
        .pipe(changed('./app/jekyll/images/'))
        .pipe(imagemin({
            optimizationLevel: 5
        }))
        .pipe(gulp.dest('./app/jekyll/images/'));
});

//
// Optimize svg and make sprites in the build folder.
//
gulp.task('svg', function() {
    return gulp.src(paths.svg)
        .pipe(svgo()())
        .pipe(imacss('_svg.scss', 'icon'))
        .pipe(gulp.dest('./app/sass/base'));
});


//
// Assemble handlebars page templates and prettify the HTML.
//
gulp.task('assemble', function() {

    var compiled = moment().format('MMMM DD, YYYY - HH:mm:ss');

    var assembleOptions = {
        data: './app/examples/data/*.json',
        partials: './app/examples/partials/*.hbs',
        layoutdir: './app/examples/layouts/'
    };

    gulp.src('./app/examples/pages/*.hbs')
        .pipe(changed('./app/build/'))
        .pipe(assemble(assembleOptions))
        .pipe(prettify({
            indent_char: ' ',
            indent_size: 2
        }))
        .pipe(replace(/##DATE##/g, compiled))
        .pipe(gulp.dest('./app/build/'))
        .pipe(connect.reload());
});


//
// Gulp task to run Jekyll
// 
gulp.task('jekyll', function (cb) {

  exec('jekyll build', function (err, stdout, stderr) {
    console.log(stdout);
    console.log(stderr);
    cb(err);
  });

});


//
// Copy Bower assets into the build folder.
//
gulp.task('bower-files', function() {
    return gulp.src(mainBowerFiles(), {
            base: './bower_components'
        })
        .pipe(gulp.dest("./app/jekyll/lib"))
});


//
// Create zip archive of static file assets
//
gulp.task('build', function() {
    return gulp.src([
            './app/jekyll/css/**.**',
            './app/jekyll/images/**/**.**',
            './app/jekyll/js/**.**',
            './app/jekyll/lib/**/**.**'
        ], {
            base: "./app/build"
        })
        .pipe(zip('_responsive.zip'))
        .pipe(gulp.dest('./static'));
});


//
// Watch files for changes and run tasks as needed.
//
gulp.task('watch', function() {
    gulp.watch('app/js/**/**', ['scripts']);
    gulp.watch('app/sass/**/*.scss', ['styles']);
    gulp.watch('app/images/**/.**', ['images']);
    gulp.watch('app/svg/**/**.svg', ['svg']);
    gulp.watch('app/jekyll/**/**', ['jekyll']);
});


//
// The default task (called when you run `gulp`)
//
gulp.task('default', ['clean', 'bower-files', 'styles', 'scripts', 'images', 'svg', 'webserver', 'watch']);


//
// The fresh task: compiles everything so we can zip it up for Cascade with 'gulp build'.
//
gulp.task('fresh', ['clean', 'bower-files', 'styles', 'scripts', 'images']);



