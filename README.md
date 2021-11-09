# WCMS styles, files & templates

This repo contains the assets to manage the look and feel of the campus WCMS websites.

## Setting up for development

1. Fork and clone this repository locally
2. Install `node` and `npm` by downloading the installer from [nodejs.com](http://nodejs.org) or with Homebrew
3. Run `npm install` in the project root to install all node dependencies
4. Run `npm run preview`
   - This fetches the HTML content from [several live sites](./test/pages.js) and saves them locally for testing.
   - `img`, `link`, and `script` tags are updated to point to local resrouces.
5. Run `npm run dev`
   - This starts Laravel Mix and builds the Sass files into ucsc.css.
   - It copies the javascript and image files into their proper location in the `dist/` folder.
   - It runs a localhost server and opens the site in a browser window.

## Deployment

This repo is connected to Netlify. Each commit to the master branch (via **pull request**) will trigger a build and deploy to webassets.ucsc.edu. The WCMS sites will load the updated stylesheets from that site.

## In progress

- Testing:
  - [x] basic comparision
  - automated visual regression
- Bundling javascript dependencies
- SVG sprites for certain icons
- Design System documentation
- Generate cache-busting code for WCMS