# Responsive web templates

Responsive reboot of UCSC web templates originally created in 2009-10. These will be the basis for new WCMS and other CMS templates.

## Dependencies

### Ruby and gems

- Ruby >=1.9 (I use [rbenv](https://github.com/sstephenson/rbenv) to manage different Ruby versions)
- [Sass](http://sass-lang.com/)
- [Bourbon](http://bourbon.io/) for helpful Sass mixin tools.
- [Neat](http://neat.bourbon.io/) for grid layout.

### Node and npm

- [Gulp](http://gulpjs.com) for building/compiling assets.
- [Grunt](http://gruntjs.com) for deployment to gh-pages.
- [Bower](http://bower.io) to manage front-end dependencies.

## Setup

1. Clone this repository locally using the Github app or with `git clone https://github.com/ucsc/webtemplates2014.git`.
2. Install Gems:
    - `gem install sass`
    - `gem install bourbon`
    - `gem install neat`
3. Install `node` and `npm` by downloading the installer from [nodejs.com](http://nodejs.org).
4. Install gulp, grunt, and bower globally: `npm install -g gulp grunt grunt-cli bower`
5. `cd` into the project  directory and run `npm install` in the project root to install all node dependencies.
6. Run `bower install` to install bower components into the `./bower_components` directory.

## Development

1. In a terminal window, run `gulp` in the project root to compile the site files and run the server and livereload (*see note below*).
2. Visit [http://localhost:8080](http://localhost:8080) to preview the site in the browser.
3. Typing CTRL-C in the Terminal window will stop the `gulp` process and the web server.

**Note**: you need to have the [LiveReload](http://livereload.com/) browser extension installed in Chrome/Firefox/Safari to enable automatic browser refreshing whenever you modify a file during development.

## Testing pull requests.

The creator of an issue-fixing branch should submit a pull-request to be tested and merged.

[This comment on stackoverflow.com](http://stackoverflow.com/questions/67699/how-to-clone-all-remote-branches-with-git/72156#72156) explains how to checkout a remote branch to your local machine for testing. For our repo, that would be:

`git checkout github/[BRANCH-NAME]`

Then run `gulp` and load the [development server](http://localhost:8080).

## Comparing to current live.

1. If you want to see the differences between our development HTML changes and the current live site, run `npm run fetch` in the command line.
    - The script fetches the files listed in `pages.json` and places them in the directory `app/current-html`.
    - You can now use a diff tool to see the differences between the live site and the development work in this repository. To see a diff, run this from the Terminal: `opendiff ./app/current-html/campus-home.html ./app/build/campus-home.html`.

## Changelog

- **June 30, 2014**: Removed Compass as a dependency to make it easier to use Sass 3.3 and specifically source maps. Also removed `scut` and `modular-scale` gem dependencies. 
