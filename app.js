"use strict";

var request     = require('request');
var cheerio     = require('cheerio');
var fs          = require('fs');
var pages       = require('./pages.js').pages;
var appPath     = "./app/html/";

// We create a new index file each time we fetch
// the sample pages, just in we've added more to the list.
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
      
      // Rewrite the CSS to use local files
      $('link').first().attr("href","css/ucsc.css");

      // Add Hammer.app reload code to the <head>
      // $('head').prepend('<!-- @reload -->');
      
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

      // Add .row elements (we'll need to change this in the WCMS later)
        var topRow = $('#topNav').html() + $('.search').html();

      var html = $.html();

      // Write the local file
      fs.writeFile(appPath + filename + ".html", html, function (err) {
        if (err) throw err;
        console.log(url + ' saved as => ' + filename + '.html');
      });

      var listing = '<li><a href="' + filename + '.html">' + filename + '</a></li>\n';

        fs.appendFile(appPath + 'index.html', listing, function (err) {
        if (err) throw err;
        // console.log(filename + ' link added to index.html.');
      });

  });

});