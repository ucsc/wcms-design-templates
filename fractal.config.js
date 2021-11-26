'use strict';

/* Create a new Fractal instance and a theme instance */
const fractal = module.exports = require('@frctl/fractal').create();
const pkg = require("./package.json");

const context = {
  package: {
    name: pkg.name,
    version: pkg.version
  },
  placeholderLink: "#"
};

/* Theme configuration */
const mandelbrot = require('@frctl/mandelbrot');
const FractalTheme = mandelbrot({
    skin: {
        name: 'default',
        accent: '#00458c',
        complement: '#fff',
        links: '#da216d',
    }
});
/* Use the configured theme by default */
fractal.web.theme(FractalTheme);

/* Set the title of the project */
fractal.set('project.title', 'UC Santa Cruz Redwood Design System');

/* Components configuration */
fractal.components.set('path', __dirname + '/src/components');
fractal.components.set("default.context", context);
fractal.components.set('statuses', {
    prototype: {
        label: "Prototype",
        description: "In development. Do not use.",
        color: "#FF3333"
    },
    "in-progress": {
        label: "In Progress",
        description: "Work in progress. Implement with caution.",
        color: "#FF9233"
    },
    ready: {
        label: "Ready",
        description: "Ready to use.",
        color: "#29CC29"
    }
});


/* Documentation configuration */
fractal.docs.set('path', __dirname + '/src/docs');
fractal.docs.set('default.status', 'draft');

/* Static HTML version of the docs and static assets configuration */
fractal.web.set('builder.dest', __dirname + '/build');
fractal.web.set('static.path', __dirname + '/dist');

/* Defaults for previewing components */
fractal.components.set('default.preview', '@preview');
fractal.components.set('default.status', 'in-progress');

