# 2014 Responsive web templates for UC Santa Cruz 

Frontend code structure for 2014 Responsive web templates for UC Santa Cruz. 

Generated 26 April 2017 using [Frontend.md](http://github.com/animade/frontend-md)

---

### Stylesheets

````
src/
|
|- sass/
|  |- ucsc.scss ______________________________ # All partials import into this file
|
|  |- regions/
|    |- _footer.scss _________________________ # Rules for the bottom area of every WCMS page
|    |- _main-content.scss ___________________ # Rules for elements in the .main-content area.
|    |- _php-content.scss ____________________ # For dynamic content on PHP pages
|    |- _site-title.scss _____________________ # Rules for the logo and site title in the second row of every page
|    |- _top-row.scss ________________________ # Rules for the the global navigation and search field at the top of every page
|
|  |- pages/
|    |- _articles.scss _______________________ # Custom styles for news articles and people profiles
|    |- _directory.scss ______________________ # Custom rules for PHP people directory pages
|    |- _feedback-form.scss __________________ # Rules for the campus feedback form on every site
|    |- _landing.scss ________________________ # Rules for second-level pages, linked from main navigation on the campus home page
|    |- _search-results.scss _________________ # Custom rules for Google search results pages
|
|  |- lib/
|    |- _billboards-default.scss _____________ # Owl Carousel default styles
|    |- _icons-data-svg.scss _________________ # Base rules for svg icons
|
|  |- components/
|    |- _accessibility-links.scss ____________ # Accessibility links we hide at the top of every page
|    |- _archive-list.scss ___________________ # Rules for a list of teasers for news articles or videos, etc.
|    |- _article-images.scss _________________ # Custom rules for images in news articles
|    |- _banners.scss ________________________ # Rules for optional banners at the top of left-column pages
|    |- _billboards.scss _____________________ # Rules for home page carousels
|    |- _block-engagement.scss _______________ # Block: three fancy links, with an image link on top (www home page only)
|    |- _block-events.scss ___________________ # Block: a list of upcoming events
|    |- _block-factoid.scss __________________ # Block: a single image fills the entire block (www site only)
|    |- _block-gallery.scss __________________ # Block: thumbnail images in a grid of 3x3
|    |- _block-images.scss ___________________ # Rules for images within blocks
|    |- _block-news.scss _____________________ # Block: news article teasers
|    |- _block-showcase.scss _________________ # Block: profiles and video teasers
|    |- _blocks.scss _________________________ # Layout rules for blocks on home pages
|    |- _breadcrumbs.scss ____________________ # Breadcrumbs appear on some pages
|    |- _callout-boxes.scss __________________ # doc
|    |- _content-box.scss ____________________ # 
|    |- _featured-story.scss _________________ # doc
|    |- _gallery.scss ________________________ # Gallery pages have linked thumbnails
|    |- _navigation-site.scss ________________ # The main navigation bar on every page
|    |- _see-also.scss _______________________ # See also links appear at the bottom of news articles and left column pages
|    |- _sidebar-left.scss ___________________ # Rules for pages with a side bar on the left
|    |- _sidebar-right.scss __________________ # Rules for a page with a sidebar on the right
|    |- _site-title.scss _____________________ # Rules to handle website titles of various lengths
|    |- _social-sharing.scss _________________ # Social media sharing links that show up at the top and bottom of news articles
|    |- _thumbnail-grid.scss _________________ # A grid of thumbnails on a page
|    |- _title-group.scss ____________________ # The title and subtitle on second-level pages of the main campus website
|
|  |- base/
|    |- _layout.scss _________________________ # Layout and grid for all WCMS pages
|    |- _legacy.scss _________________________ # Carry-overs because their functionality would need to be replaced on a site-by-site basis.
|    |- _mixins.scss _________________________ # 
|    |- _modifiers.scss ______________________ # Classes that modify the deafult display of elements.
|    |- _print.scss __________________________ # Print styles to make everything look great on dead trees
|    |- _reset.scss __________________________ # Reset styles created by someone cool on the internet
|    |- _svg.scss ____________________________ # Embedded svg icons
|    |- _typography.scss _____________________ # Base typography
|    |- _variables.scss ______________________ # All the variables used in the stylesheet
````

### Javascripts

````
src/
|
|- js/
|  |- billboards.init.js _____________________ # 
|  |- fancybox.init.js _______________________ # 
|  |- main.js ________________________________ # 
|  |- responsive.js __________________________ # 
````