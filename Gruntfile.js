'use strict';

// # Globbing
// for performance reasons we're only matching one level down:
// 'test/spec/{,*/}*.js'
// use this if you want to recursively match all subfolders:
// 'test/spec/**/*.js'

module.exports = function (grunt) {

    // Load grunt tasks automatically
    require('load-grunt-tasks')(grunt);

    // Time how long tasks take. Can help when optimizing build times
    require('time-grunt')(grunt);

    // Define the configuration for all the tasks
    grunt.initConfig({

        // [UCSC] Add the built site to the gh-pages branch
        'gh-pages': {
            options: {
                base: 'app'
            },
            src: ['*.html', 'css/*.css', 'js/*.js', 'vendor']
        }

    });

    grunt.registerTask('deploy', [
        'gh-pages'
    ]);

    grunt.registerTask('default', [
        'deploy'
    ]);

};
