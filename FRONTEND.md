# 2014 Responsive web templates for UC Santa Cruz 

Frontend code structure for 2014 Responsive web templates for UC Santa Cruz. 

Generated 25 April 2017 using [Frontend.md](http://github.com/animade/frontend-md)

---

### Stylesheets

````
src/
|
|- sass/
|  |- ucsc.scss ______________________________ # Include Ruby gems
|
|  |- regions/
|    |- _footer.scss _________________________ # 
|    |- _main-content.scss ___________________ # Basic rules for elements in the .main-content area.
|    |- _php-content.scss ____________________ # Style rules for dynamic content on PHP pages.
|    |- _site-title.scss _____________________ # At minimum, contains the UCSC logo.
|    |- _top-row.scss ________________________ # The top row of the page, containing the global UCSC
|
|  |- pages/
|    |- _articles.scss _______________________ # Article
|    |- _directory.scss ______________________ # 
|    |- _feedback-form.scss __________________ # 
|    |- _landing.scss ________________________ # 
|    |- _search-results.scss _________________ # 
|    |- _thumbnail-grid.scss _________________ # 
|
|  |- lib/
|    |- _billboards-default.scss _____________ # 
|    |- _icons-data-svg.scss _________________ # 
|
|  |- components/
|    |- _accessibility-links.scss ____________ # Hide access links
|    |- _archive-list.scss ___________________ # Archive list
|    |- _article-images.scss _________________ # doc
|    |- _banners.scss ________________________ # 
|    |- _billboards.scss _____________________ # 
|    |- _block-engagement.scss _______________ # doc
|    |- _block-events.scss ___________________ # 
|    |- _block-factoid.scss __________________ # 
|    |- _block-gallery.scss __________________ # 
|    |- _block-images.scss ___________________ # Image styles for blocks
|    |- _block-news.scss _____________________ # 
|    |- _block-showcase.scss _________________ # 
|    |- _blocks.scss _________________________ # 
|    |- _breadcrumbs.scss ____________________ # Breadcrumb styles
|    |- _callout-boxes.scss __________________ # doc
|    |- _content-box.scss ____________________ # 
|    |- _dropdown.scss _______________________ # 
|    |- _featured-story.scss _________________ # doc
|    |- _gallery.scss ________________________ # 
|    |- _navigation-site-v1.scss _____________ # 
|    |- _navigation-site-v2.scss _____________ # 
|    |- _navigation-site.scss ________________ # 
|    |- _see-also.scss _______________________ # 
|    |- _sidebar-left.scss ___________________ # 
|    |- _sidebar-right.scss __________________ # 
|    |- _site-title.scss _____________________ # Page title classes for titles of different lengths
|    |- _social-sharing.scss _________________ # 
|    |- _title-group.scss ____________________ # doc
|
|  |- base/
|    |- _functions.scss ______________________ # 
|    |- _layout.scss _________________________ # Layout and grid
|    |- _legacy.scss _________________________ # doc
|    |- _mixins.scss _________________________ # 
|    |- _modifiers.scss ______________________ # Classes that modify the deafult display of elements.
|    |- _print.scss __________________________ # 
|    |- _reset.scss __________________________ # 
|    |- _svg.scss ____________________________ # 
|    |- _typography.scss _____________________ # 
|    |- _variables.scss ______________________ # Colors
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