"use strict";

const fs          = require('fs');
const mkdirp      = require('mkdirp');
const rp          = require('request-promise');
const cheerio     = require('cheerio');
const hbs         = require('handlebars');
const pages       = require('./pages.js').pages;
const appPath     = "./dist/";

// We create a new index file each time we fetch
// the sample pages, just in case we've added more to the list.
fs.open(appPath + 'index.html', "r", function (err, fd) {
    if (fd) {
        fs.unlink(appPath + 'index.html', function (err) {
          if (err) throw err;
          console.log('Removing index.html...');
        });
    } 
    else {
      console.error('No index.html file. Proceeding...');
    };
});


pages.forEach(function (i) {

  var filename = i.name,
        site = i.site,
        path = i.path,
        file = i.file,
        url = site + path + file;

  // Fetch the content from the live site URL      
  rp(url)
    .then(function(html) {
      
      // Load the response into the parser
      var $ = cheerio.load(html);
      
      // Iterate over <link> tags to use relative file paths 
      $('link').map(function(i, el) {
        // Get the 'src' attr for the image and replace with a relative path
        var hrefSrc = $(this).attr('href').replace(/^(https\:)?\/\/(webassets|static).ucsc.edu\/(_responsive\/)?/gm, "");
        
        $(this).attr('href', hrefSrc);
      });

      // Iterate over <script> tags to use relative file paths 
      $('script').map(function(i, el) {
        // Get the 'src' attr for the script and replace with a relative path
        if ($(this).attr('src')) {
          var scriptSrc = $(this).attr('src').replace(/^(https\:)?\/\/(webassets|static).ucsc.edu\/(_responsive\/)?/gm, "");
          $(this).attr('src', scriptSrc);
        }
      });

      // Iterate over <img> tags to look for relative 'src' paths 
      $('img').map(function(i, el) {
        // Get the 'src' attr for the image
        var imgsrc = $(this).attr('src');
        // Crudely see if the path is relative or absolute
        if (imgsrc.indexOf('http') == -1) {
          // Prepend the site path to the 'src' attr
          $(this).attr('src', site + path + imgsrc);
        };
      });

      // Parsed and fixed contents for our local file
      var fileContents = $.html();

      // Write the local file
      mkdirp(appPath, function(err) {
        fs.writeFile(appPath + filename + ".html", fileContents, function (err) {
          if (err) throw err;
          console.log('Fetched ' + url + ' as => ' + filename + '.html');
        });
      });

    })
    .catch(function(err) {
      console.log('Error: ' + err);
    });

});

// Use Handlebars to convert the list of sample pages
// to an index file for the local test server
fs.readFile('test/template.html', function(err, templateFile) {

  hbs.registerHelper('fetched', function() {
    var today = new Date();
    var date = today.toDateString();
    var time = today.toLocaleTimeString('en-US');
    return date + ' at ' + time;
  });
  
  var template  = hbs.compile(templateFile.toString());
  var htmlFinal = template({pages: pages});
  
  mkdirp(appPath, function(e) {
    fs.writeFile(appPath + 'index.html', htmlFinal, (err) => {
      if (err) throw err;
      console.log('index.html file saved');
    });
  });
  
});


