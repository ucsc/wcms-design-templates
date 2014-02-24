var pkg 				= require('./package.json'),
		gulp 				= require('gulp'),
		autoprefix 	= require('gulp-autoprefixer'),
		compass 		= require('gulp-compass'),
		concat			= require('gulp-concat'),
		clean 			= require('gulp-clean'),
		notify 			= require('gulp-notify'),
		refresh 		= require('gulp-livereload'),
		lr 					= require('tiny-lr'),
		server 			= lr();
var	awspublish = require('gulp-awspublish'),
    publisher = awspublish.create({ key: 'AKIAIPBYQFIQEBMBAFTA', secret: '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', bucket: 'ucscwebtemplates'}),
    headers = { 'Cache-Control': 'max-age=315360000, no-transform, public' };


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
	gulp.src([
		'./app/bower_components/bootstrap-sass-official/vendor/assets/stylesheets/bootstrap/_carousel.scss',
		'./app/sass/*.scss'])
		.pipe(compass({
			css: './app/css',
			sass: './app/sass',
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

gulp.task('release', function() {
		gulp.src('./app/**/*.{html,css,jpg,png,js}')
		.pipe(publisher.publish(headers));
});

// The default task (called when you run `gulp`)
gulp.task('default', ['clean', 'styles', 'lr-server'], function() {

		gulp.watch('app/sass/*.scss', ['styles']);
		gulp.watch('app/*.html', ['html']);

});