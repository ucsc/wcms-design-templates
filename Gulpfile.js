var pkg = require('./package.json');
var gulp = require('gulp');
var compass = require('gulp-compass');
var clean = require('gulp-clean');
var notify = require('gulp-notify');
var refresh = require('gulp-livereload');
var lr = require('tiny-lr')
var server = lr();


// Create a server to preview our built pages
gulp.task('lr-server', function() {  
    server.listen(35729, function(err) {
        if(err) return console.log(err);
    });
});

// Clean the compiled assets so we start fresh
gulp.task('clean', function() {
	gulp.src('app/css', {read: false})
		.pipe(clean());
});

gulp.task('compass', function() {
	gulp.src('./sass/*.scss')
		.pipe(compass({
			css: 'app/css',
			sass: 'sass',
			image: 'app/images',
			require: ['bourbon', 'neat']
	}))
		.pipe(refresh(server))
		.pipe(notify("Compass task was run."));
});

// The default task (called when you run `gulp`)
gulp.task('default', function() {
 		
 		gulp.run('clean', 'compass', 'lr-server');

		gulp.watch('sass/*.scss', function() {
		  gulp.run('compass');
		});
  
});