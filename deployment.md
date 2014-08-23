# Follow this process to deploy the new templates to the WCMS

## 1. Add static files to the static site. 

- Run `gulp build` inside the repo.
- Upload ./static/_responsive.zip to the static site and publish it.
-  Be sure to upload the zip *inside* the _responsive folder.

## 2. Add/update Data Definitions:

- Add  _library/Global/script-and-style-chooser
- Update the billboard `<group>` in
	- _library/Data Definitions/Campus Home Environment/home-page
	- _library/Data Definitions/Department or Division/Department or Division Home

## 3. Create new blocks in _library/global.

- blocks/features:
	- billboards (xhtml)
	- fancybox (xhtml)
	- feature-template (xhtml)
- blocks:
	- uniform-campus-head (text)
	- uniform-home-page-head (xhtml, w/chooser dd)
		- Choose billboards and fancybox
	- uniform-gallery-page-head (xhtml, w/chooser dd)
		- Choose fancybox

## 4. Create new formats in _library/global/formats.

- billboards
- breadcrumbs -> Breadcrumbs.xsl
- local-html-head
- region-block-chooser

## 5. Update all templates and Region Assignments

## 6. Update formats

## 7. Sites

- News
	+ Create `department-title` block.
	+ Create search block.
	+ Assign main-nav, search, top-links regions

## Misc.

- www: 
	- Features area, remove all but one of `article-list-by-page-metadata` and move it to `_library/campus-home/formats/features-article-list`. 
	- Add `image-right` to the archive-list ul. Reassign these regions on the features pages.
	- REMOVE `Right Column Page` template #notused
	- Rename 960 Right Column to just Right Column Page
