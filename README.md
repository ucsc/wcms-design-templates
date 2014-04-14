# Responsive web templates

Responsive reboot of UCSC web templates originally created in 2009-10. These will be the basis for new WCMS and other CMS templates.

## Dependencies

### Ruby and gems

- Ruby >=1.9 (I use [rbenv](https://github.com/sstephenson/rbenv) to manage different Ruby versions)
- [Sass](http://sass-lang.com/) & [Compass](http://compass-style.org/)
- [Bourbon](http://bourbon.io/) for helpful Sass mixin tools.
- [Neat](http://neat.bourbon.io/) for grid layout.
- [Modular Scale](https://github.com/Team-Sass/modular-scale) for consistent typography.

### Node and npm

- [Gulp](http://gulpjs.com) for building/compiling assets.
- [Grunt](http://gruntjs.com) for deployment to gh-pages.
- [Bower](http://bower.io) to manage front-end dependencies.

## Setup

1. Fork/clone this repository locally using the Github app or with `git clone https://github.com/ucsc/webtemplates2014.git`.
2. Install Compass/Sass: `gem install compass`
3. Install Gems:
    - `gem install bourbon`
    - `gem install neat`
    - `gem install modular-scale`
4. Install `node` and `npm` by downloading the installer from [nodejs.com](http://nodejs.org).
5. Install gulp, grunt, and bower globally: `npm install -g gulp grunt grunt-cli bower`
6. `cd` into the project  directory and run `npm install` in the project root to install all node dependencies.
7. Run `bower install` to install bower components into the `./bower_components` directory.

## Development

1. In a terminal window, run `node server.js` to start the static web server.
1. In a new terminal window/tab, run `gulp` in the project root to compile the site files and run the livereload server [^1].
2. Visit [http://localhost:8000](http://localhost:8000) to preview the site in the browser.
3. Typing CTRL-C in the Terminal window will stop the `gulp` process and the web server.

[^1]: Note that you need to have the [LiveReload](http://livereload.com/) browser extension installed in Chrome/Firefox/Safari to enable automatic browser refreshing whenever you modify a file during development.

## Comparing to current live.

1. If you want to see the differences between our development HTML changes and the current live site, run `npm run fetch` in the command line.
    - The script fetches the files listed in `pages.json` and places them in the directory `app/current-html`.
    - You can now use a diff tool to see the differences between the live site and the development work in this repository. To see a diff, run this from the Terminal: `opendiff ./app/current-html/campus-home.html ./app/build/campus-home.html`.