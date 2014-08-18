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
    connect = require('gulp-connect');


// Set default file path variables for tasks
var paths = {
    styles: ['./app/sass/*.scss', './app/sass/**/**.**'],
    scripts: './app/js/**/**',
    images: './app/images/**/**',
    fonts: './app/fonts/*'
};

// Static webserver with livereload via connect
gulp.task('webserver', function() {
    connect.server({
        livereload: true,
        root: ['./app/build']
    });
});


// Clean the build folder so we start clean
gulp.task('clean', function() {
    gulp.src(['app/build/css', 'app/build/js', 'app/build/*.html'], {
        read: false
    })
        .pipe(clean());
});


// Compile sass into CSS with sourcemap.
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
        .pipe(gulp.dest('./app/build/css/'))
        .pipe(connect.reload());
});


// Uglify scripts into the build folder.
gulp.task('scripts', function() {
    return gulp.src(paths.scripts)
        // Pass in options to the task
        .pipe(changed('./app/build/js/'))
        .pipe(uglify())
        .pipe(gulp.dest('./app/build/js/'));
});


// Optimize and copy images into the build folder.
gulp.task('images', function() {
    return gulp.src(paths.images)
        .pipe(changed('./app/build/images/'))
        .pipe(imagemin({
            optimizationLevel: 5
        }))
        .pipe(gulp.dest('./app/build/images/'));
});


// Assemble handlebars page templates and prettify the HTML.
gulp.task('assemble', function() {

    var compiled = moment().format('MMMM DD, YYYY - HH:mm:ss');

    var assembleOptions = {
        data: './app/data/*.json',
        partials: './app/partials/*.hbs',
        layoutdir: './app/layouts/'
    };

    gulp.src('./app/pages/*.hbs')
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


// Copy font files into the build folder.
gulp.task('fonts', function() {
    gulp.src(paths.fonts)
        .pipe(gulp.dest('./app/build/fonts/'));
});


// Copy Bower assets into the build folder.
gulp.task('bower-files', function() {
    return gulp.src(mainBowerFiles(), {
            base: './bower_components'
        })
        .pipe(gulp.dest("./app/build/lib"))
});


// Create zip archive of static file assets
gulp.task('build', function() {
    return gulp.src([
            './app/build/css/**.**',
            './app/build/fonts/**.**',
            './app/build/images/**/**.**',
            './app/build/js/**.**',
            './app/build/lib/**/**.**'
        ], {
            base: "./app/build"
        })
        .pipe(zip('_responsive.zip'))
        .pipe(gulp.dest('./static'));
});


// Watchers
gulp.task('watch', function() {
    gulp.watch('app/js/**/**', ['scripts']);
    gulp.watch('app/sass/**/*.scss', ['styles']);
    gulp.watch('app/images/**/.**', ['images']);
    gulp.watch(['app/layouts/*.hbs', 'app/partials/*.hbs', 'app/pages/*.hbs'], ['assemble']);
});

// The default task (called when you run `gulp`)
gulp.task('default', ['clean', 'bower-files', 'styles', 'scripts', 'images', 'fonts', 'assemble', 'webserver', 'watch']);


// The default task (called when you run `gulp`)
gulp.task('deploy', ['clean', 'bower-files', 'styles', 'scripts', 'images', 'fonts', 'build']);