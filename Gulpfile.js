var pkg = require('./package.json'),
    gulp = require('gulp'),
    autoprefix = require('gulp-autoprefixer'),
    compass = require('gulp-compass'),
    concat = require('gulp-concat'),
    minifycss	= require('gulp-minify-css'),
    clean = require('gulp-clean'),
    notify = require('gulp-notify'),
    uglify = require('gulp-uglify'),
    refresh = require('gulp-livereload'),
    fileinclude = require('gulp-file-include'),
    prettify = require('gulp-html-prettify'),
    imagemin = require('gulp-imagemin'),
    gulpBowerFiles = require('gulp-bower-files'),
    connect = require('gulp-connect');


// Static webserver with livereload via connect
gulp.task('webserver', function() {
  connect.server({
    livereload: true,
    root: ['./app/build']
  });
});

// Clean the build folder so we start fresh
gulp.task('clean', function() {
  gulp.src(['app/build/css', 'app/build/js', 'app/build/*.html'], {read: false})
  .pipe(clean());
});

// Run Sass with Compass to compile, prefix, and compress styles
// then copy to the build folder.
gulp.task('styles', function() {
  gulp.src(['./app/sass/*.scss'])
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
    // Pass in options to the task
    .pipe(imagemin({optimizationLevel: 5}))
    .pipe(gulp.dest('./app/build/images/'));
});

// Add partials to HTML, then prettify and copy into the build folder.
gulp.task('templates', function() {
  gulp.src(['./app/*.html', './app/html-partials/*.*'])
  .pipe(fileinclude())
  .pipe(prettify({indent_char: ' ', indent_size: 2}))
  .pipe(gulp.dest('./app/build/'))
  .pipe(connect.reload());
});

// Add partials to HTML, then prettify and copy into the build folder.
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
  gulp.watch('app/sass/**/*.scss', ['styles']);
  gulp.watch('app/images/*.*', ['images']);
  gulp.watch(['app/*.html', 'app/html-partials/*.html'], ['templates']);
});

// The default task (called when you run `gulp`)
gulp.task('default', ['clean', 'bower-files', 'styles', 'scripts', 'images', 'fonts', 'templates', 'webserver', 'watch']);