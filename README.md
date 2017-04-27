# Responsive web templates

Responsive reboot of UCSC web templates originally created in 2009-10.

- [Sass and Javascript file structure](FRONTEND.md)

## Setting up for development

### Ruby and gems

- Ruby >2.2.0 (we use [rbenv](https://github.com/sstephenson/rbenv) to manage Ruby versions)
- [Sass](http://sass-lang.com/)
- [Bourbon](http://bourbon.io/) for helpful Sass mixin tools.
- [Neat](http://neat.bourbon.io/) for grid layout.

### Node and npm

- [Gulp](http://gulpjs.com) for building/compiling assets.
- [Bower](http://bower.io) to manage front-end dependencies.

## Setup

1. Clone this repository locally using the Github app or with `git clone https://github.com/ucsc/webtemplates2014.git`.
2. Install Gems:
    - `gem install sass`
    - `gem install bourbon`
    - `gem install neat`
3. Install `node` and `npm` by downloading the installer from [nodejs.com](http://nodejs.org) or with Homebrew.
4. Install gulp and bower globally: `npm install -g gulp bower`
5. `cd` into the project  directory and run `npm install` in the project root to install all node dependencies.
6. Run `bower install` to install bower components into the `./bower_components` directory.

## Development

1. In a terminal window, `cd` into the project directory and run `node app.js` to fetch the example HTML files<sup>1</sup> from the website. 
2. Run `gulp` to start the local web server and compile the site files.
2. Visit [http://localhost:8080/examples/](http://localhost:8080/examples/) to preview the site in the browser.

Type CTRL-C in the Terminal window will stop the `gulp` process and the web server.

**Note**: you may need to have the [LiveReload](http://livereload.com/) browser extension installed in Chrome/Firefox/Safari to enable automatic browser refreshing whenever you modify a file during development.

#### Footnotes

1. The script `app.js` fetches the files listed in `pages.json` and places them in the directory `examples`. The web server serves those files from [`localhost:8080/examples/`](http://localhost:8080/examples/)
