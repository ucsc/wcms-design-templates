var pkg 				= require('./package.json'),
		gulp 				= require('gulp'),
		autoprefix 	= require('gulp-autoprefixer'),
		compass 		= require('gulp-compass'),
		clean 			= require('gulp-clean'),
		notify 			= require('gulp-notify'),
		refresh 		= require('gulp-livereload'),
		lr 					= require('tiny-lr'),
		server 			= lr();


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

gulp.task('styles', function() {
	gulp.src('./sass/*.scss')
		.pipe(compass({
			css: 'app/css',
			sass: 'sass',
			image: 'app/images',
			require: ['bourbon', 'neat']}))
		.pipe(autoprefix('last 2 versions'))
    .pipe(gulp.dest('./app/css/'))
		.pipe(refresh(server));
		// .pipe(notify("Compass task was run."));
});

gulp.task('html', function(){  
    gulp.src('./app/*.html')
    .pipe(refresh(server));
});

// The default task (called when you run `gulp`)
gulp.task('default', ['clean', 'styles', 'lr-server'], function() {

		gulp.watch('sass/*.scss', function() {
		  gulp.run('styles');
		});
  
		gulp.watch('app/*.html', function() {
		  gulp.run('html');
		});  	

});