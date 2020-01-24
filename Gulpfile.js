// Load Gulp functions so we don't have to use "gulp" everywhere.
const { src, dest, watch, series, parallel } = require('gulp');

// Import the packages to use with Gulp
const sourcemaps = require('gulp-sourcemaps');
const sass = require('gulp-sass');
const concat = require('gulp-concat');
const uglify = require('gulp-uglify');
const postcss = require('gulp-postcss');
const autoprefixer = require('autoprefixer');
const cssnano = require('cssnano');
const gnd = require('gulp-npm-dist');
const del = require('del');
const include = require('gulp-file-include');
const zip = require('gulp-zip');
const browserSync = require('browser-sync').create();
var replace = require('gulp-replace');
var pkg = require('./package.json');
    
sass.compiler = require('node-sass');
    

//
// Paths for source and output files
//
var paths = {
    styles: {
      source: 'src/sass/**/*.scss',
      dest:   'dist/css'
    },
    scripts: {
      source: 'src/js/*.js',
      dest:   'dist/js'
    },
    html: {   
      source: 'src/html/*.html',
      dest:   'dist'
    },
    images: {
      source: 'src/images/**/**',
      dest:    'dist/images'
    },
    svg: {
      source: 'src/svg/**/**.svg',
      dest:   'dist/images/svg'
    }
};


//
// Clean the build folder.
//
function clean(cb) {
  del.sync([
    'dist/**'
  ], cb());
}


//
// Compile sass into CSS and a source map.
//
function styles() {
  return src(paths.styles.source)
    .pipe(sourcemaps.init())
    .pipe(sass({
      outputStyle: 'expanded'
    }).on('error', sass.logError))
    .pipe(postcss([ autoprefixer(), cssnano() ]))
    .pipe(sourcemaps.write('.'))
    .pipe(dest(paths.styles.dest))
    .pipe(browserSync.stream());
}


//
// Uglify scripts into the build folder.
//
function scripts() {
  return src([
    paths.scripts.source
  ])
  .pipe(concat('main.js'))
  .pipe(uglify())
  .pipe(dest(paths.scripts.dest))
  .pipe(browserSync.reload({ stream: true }));  
}

//
// Copy HTML files
//
function html() {
  return src('./src/html/index.html')
    .pipe(include({
      prefix: '@@',
      basepath: '@file'
    }))
    .pipe(dest(paths.html.dest))
    .pipe(browserSync.reload({ stream: true }));
}

//
// Copy dependencies from package.json to dist folder
// 
function libraries() {
  return src(gnd(), { base: './node_modules'})
    .pipe(dest('dist/libs'))
    .pipe(browserSync.reload({ stream: true }));
}

//
// Optimize and copy images into the build folder.
//
// gulp.task('images', function() {
//     return gulp.src(paths.images)
//         .pipe(changed('./build/_responsive/images/'))
//         .pipe(imagemin({
//             optimizationLevel: 5
//         }))
//         .pipe(gulp.dest('./build/_responsive/images/'));
// });


//
// Optimize SVG and make sprites in the build folder.
//
// gulp.task('svg', function() {
//     return gulp.src(paths.svg)
//         .pipe(svgo()())
//         .pipe(imacss('_svg.scss', 'icon'))
//         .pipe(gulp.dest('./src/sass/base'));
// });



//
// Copy old assets from previous design into the build folder.
//
// gulp.task('archive-files', function() {
//     return gulp.src('./src/archive/**')
//         .pipe(gulp.dest("./build"));
// });


//
// Create zip archive of static file assets ready for the WCMS.
//
function buildZip() {
    return src([
            './dist/**/**'
        ])
        .pipe(zip('wcms-static.zip'))
        .pipe(dest('./deploy'));
}


//
// Rerun all tasks when files change
//
function dev() {
  browserSync.init({
    port: 8888,
    server: {
      baseDir: './dist'
    }
  });
  watch(paths.styles.source, styles);
  watch(paths.scripts.source, scripts);
  watch(paths.html.source, html);
}



exports.default = series(clean, parallel(html, styles, scripts, libraries));
exports.watch = series(clean, parallel(html, styles, scripts, libraries), dev);
exports.deploy = series(clean, parallel(html, styles, scripts, libraries), buildZip);