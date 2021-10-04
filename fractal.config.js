'use strict';

/* Create a new Fractal instance and export it for use elsewhere if required */
const fractal = module.exports = require('@frctl/fractal').create();

/* Set the title of the project */
fractal.set('project.title', 'UC Santa Cruz Redwood Design System');

/* Tell Fractal where the components will live */
fractal.components.set('path', __dirname + '/src/components');

/* Tell Fractal where the documentation pages will live */
fractal.docs.set('path', __dirname + '/src/docs');

/* Where to build the static HTML version of the docs and place static assets */
fractal.web.set('builder.dest', __dirname + '/build');
fractal.web.set('static.path', __dirname + '/public');

/* Set a default preview layout to display rendered components */
fractal.components.set('default.preview', '@preview');