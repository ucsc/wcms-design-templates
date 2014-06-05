var pkg = require('./package.json'),
    gulp = require('gulp'),
    changed = require('gulp-changed'),
    autoprefix = require('gulp-autoprefixer'),
    compass = require('gulp-compass'),
    concat = require('gulp-concat'),
    minifycss	= require('gulp-minify-css'),
    clean = require('gulp-clean'),
    uglify = require('gulp-uglify'),
    refresh = require('gulp-livereload'),
    assemble = require('gulp-assemble'),
    prettify = require('gulp-html-prettify'),
    replace = require('gulp-replace'),
    imagemin = require('gulp-imagemin'),
    moment = require('moment'),
    gulpBowerFiles = require('gulp-bower-files'),
    connect = require('gulp-connect');


// Static webserver with livereload via connect
gulp.task('webserver', function() {
  connect.server({
    livereload: true,
    root: ['./app/build']
  });
});


// Clean the build folder so we start clean
gulp.task('clean', function() {
  gulp.src(['app/build/css', 'app/build/js', 'app/build/*.html'], {read: false})
  .pipe(clean());
});


// Run Sass with Compass to compile, prefix, 
// and compress styles then copy to the build folder.
gulp.task('styles', function() {
  gulp.src(['./app/sass/*.scss'])
  .pipe(changed('./app/build/css/'))
  .pipe(compass({
   css: './app/build/css',
   sass: './app/sass',
   images: './app/build/images/',
   require: ['bourbon', 'neat', 'modular-scale', 'scut']
   }))
  .on('error', function(err) { console.log(err); })
  .pipe(autoprefix('last 4 versions'))
  .pipe(minifycss())
  .pipe(gulp.dest('./app/build/css/'))
  .pipe(connect.reload());
  });


// Uglify scripts into the build folder.
gulp.task('scripts', function() {
 return gulp.src('./app/js/**/**')
    // Pass in options to the task
    .pipe(uglify())
    .pipe(gulp.dest('./app/build/js/'));
});


// Optimize and copy images into the build folder.
gulp.task('images', function() {
 return gulp.src('./app/images/**/**')
    .pipe(changed('./app/build/images/'))
    .pipe(imagemin({optimizationLevel: 5}))
    .pipe(gulp.dest('./app/build/images/'));
});


// Assemble handlebars page templates and prettify the HTML.
gulp.task('assemble', function () {

  var compiled = moment().format('MMMM DD, YYYY - HH:mm:ss');
  
  var assembleOptions = {
    data: './app/data/*.json',
    partials: './app/partials/*.hbs',
    layoutdir: './app/layouts/'
  };

  gulp.src('./app/pages/*.hbs')
    .pipe(changed('./app/build/'))
    .pipe(assemble(assembleOptions))
    .pipe(prettify({indent_char: ' ', indent_size: 2}))
    .pipe(replace(/##DATE##/g, compiled))
    .pipe(gulp.dest('./app/build/'))
    .pipe(connect.reload());
});


// Copy font files into the build folder.
gulp.task('fonts', function() {
  gulp.src('./app/fonts/*')
  .pipe(gulp.dest('./app/build/fonts/'));
});


// Copy Bower assets into the build folder.
gulp.task('bower-files', function(){
    gulpBowerFiles().pipe(gulp.dest("./app/build/lib"));
});


// Watchers
gulp.task('watch', function () {
  gulp.watch('app/js/**/**', ['scripts']);
  gulp.watch('app/sass/**/*.scss', ['styles']);
  gulp.watch('app/images/*.*', ['images']);
  gulp.watch(['app/layouts/*.hbs', 'app/partials/*.hbs', 'app/pages/*.hbs'], ['assemble']);
});

// The default task (called when you run `gulp`)
gulp.task('default', ['clean', 'bower-files', 'styles', 'scripts', 'images', 'fonts', 'assemble', 'webserver', 'watch']);