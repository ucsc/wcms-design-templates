# Responsive web templates

Responsive reboot of UCSC web templates originally created in 2009-10. These will be the basis for new WCMS templates.

## Dependencies

- Ruby >=1.9 (I use [rbenv](https://github.com/sstephenson/rbenv) to manage different Ruby versions)
- [Sass](http://sass-lang.com/) & [Compass](http://compass-style.org/)
- [Bourbon](http://bourbon.io/)
- [Node/NPM](http://nodejs.org)
- [Grunt](http://gruntjs.com/) (For deployment to gh-pages) 


## Setup

1. Clone this repository locally using the Github app or with `git clone https://github.com/ucsc/webtemplates2014.git`.
2. Install Compass/Sass: `gem install compass`
3. Install Bourbon: `gem install bourbon`
4. Install `node` and `npm` by downloading the installer from [nodejs.com](http://nodejs.org).
5. Install gulp, grunt, and bower globally: `npm install -g gulp grunt grunt-cli bower`
6. `cd` into the project  directory and run `npm install` in the project root to install all node dependencies.
7. Run `bower install` to install bower components into the ./app/vendor directory.

## Development

1. Run `gulp` in the project root to build the stylesheets and javascript and run the livereload server [^1].
2. You can preview files in the browser or by using a development server (we're using [Pow](http://pow.cx) via [Anvil](http://anvilformac.com)).
3. Typing CTRL-C in the Terminal window will stop the `gulp` process.

[^1]: Note that you need to have the [LiveReload](http://livereload.com/) browser extension installed in Chrome/Firefox/Safari to enable automatic browser refreshing whenever a file is modified during development.

## Comparing to current live.

1. If you want to see the differences between our development HTML changes and the current live site, run `npm run fetch` in the command line.
    - The script fetches the files listed in `pages.json` and places them in the directory `app/current-html`.
    - You can now use a diff tool to see the differences between the live site and the development work in this repository. To see a diff, run this from the Terminal: `opendiff ./app/current-html/campus-home.html ./app/campus-home.html` 