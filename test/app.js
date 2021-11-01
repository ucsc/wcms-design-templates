"use strict";

var request     = require('request');
var cheerio     = require('cheerio');
var fs          = require('fs');
var mkdirp      = require('mkdirp');
var pages       = require('./pages.js').pages;
var appPath     = "./dist/";

// We create a new index file each time we fetch
// the sample pages, just in case we've added more to the list.
fs.exists(appPath + 'index.html', function (exists) {
    if (exists) {
        fs.unlink(appPath + 'index.html', function (err) {
         if (err) throw err;
        console.log('Removing index.html...');
        });
    };
});



pages.forEach(function (i) {

  // console.log(i.name);
  var filename = i.name,
        site = i.site,
        path = i.path,
        file = i.file,
        url = site + path + file;

  // Let us know you've started
  console.log('Fetching: ' + url);

  request(url, function(error, response, body) {
    
      // Report errors
      if (error) throw error;

      // Load the response into the parser
      var $ = cheerio.load(body);
      
      // Iterate over <link> tags to use relative file paths 
      $('link').map(function(i, el) {
        // Get the 'src' attr for the image and replace with a relative path
        var hrefSrc = $(this).attr('href').replace(/^\/\/static.ucsc.edu\//gm, "");
        $(this).attr('href', hrefSrc);
      });

      // Iterate over <link> tags to use relative file paths 
      $('script').map(function(i, el) {
        // Get the 'src' attr for the script and replace with a relative path
        if ($(this).attr('src')) {
          var scriptSrc = $(this).attr('src').replace(/^\/\/static.ucsc.edu\//gm, "");
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

      var html = $.html();

      // Write the local file
      mkdirp(appPath, function(err) {
        fs.writeFile(appPath + filename + ".html", html, function (err) {
          if (err) throw err;
          console.log(url + ' saved as => ' + filename + '.html');
        });
      });

      var listing = '<li><a href="' + filename + '.html">' + filename + '</a></li>\n';

        fs.appendFile(appPath + 'index.html', listing, function (err) {
        if (err) throw err;
        // console.log(filename + ' link added to index.html.');
      });

  });

});