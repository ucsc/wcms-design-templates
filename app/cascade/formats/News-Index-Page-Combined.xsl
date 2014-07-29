<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xmlns:func="http://exslt.org/functions" xmlns:hh="http://www.hannonhill.com/XSL/Functions" xmlns:ucsc="http://ucsc.edu/xslt/functions">
     <!-- This format creates an index page that combines content from a specific local folder with content from an index of the most recent 200 articles from another site (the main campus news source). The block is a structured data block that combines the the two types of index blocks.
     The local folder can contain two different content types: one is a regular news article and the other is a news article shortcut. They share basic metadata and thumbnail but the shortcut otherwise is just a page, URL, or file chooser. -->   
     
        <xsl:output indent="yes" method="xml"/> 
      <xsl:include href="/formats/Format Date"/>
      
      
<!-- A note about the date formats:  This format uses xml of articles with two different date formats and needs to sort in date order. 
To accomplish standardization of the two different formats, an EXSLT function has been developed that (a) detects which format the source date is in and (b) converts the date to a standard sortable format.  Ross - the Oracle - Williams from Hannon Hill wrote this.  -->
   
        <func:function name="ucsc:standardizePageDate">
            <xsl:param name="page"/>
            <xsl:variable name="dateMask">yyyymmddHHMMss</xsl:variable>
            <func:result>
                <xsl:choose>
                    <xsl:when test="$page/system-data-structure/page/path != '/'">
                        <xsl:call-template name="format-date-string">
                            <xsl:with-param name="date" select="$page/system-data-structure/page/start-date"/>
                            <xsl:with-param name="mask" select="string($dateMask)"/>
                        </xsl:call-template>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:call-template name="format-date">
                            <xsl:with-param name="date" select="$page/start-date"/>
                            <xsl:with-param name="mask" select="string($dateMask)"/>
                        </xsl:call-template> 
                    </xsl:otherwise>
                </xsl:choose>
            </func:result>
        </func:function>
        
        <xsl:variable name="current-page" select="/system-data-structure/combined-news/dept-news/content/system-index-block/calling-page/system-page"/>
        <xsl:variable name="current-date" select="/system-data-structure/combined-news/campus-news/content/system-index-block/@current-time"/>
        <xsl:variable name="news-categories" select="$current-page/dynamic-metadata[starts-with(name,'category-')]/value"/>
        
        <!-- the news-categories variable defines one or more categories associated with the metadata of the index page which will be used to match articles from the central campus news source that have the same category.
        We identify which metadata corresponds to news categories as those in which the name element starts with "category-". -->

        <xsl:template match="/system-data-structure">
            <xsl:variable name="campus-index-block" select="combined-news/campus-news/content/system-index-block"/>
            <xsl:variable name="dept-index-block" select="combined-news/dept-news/content/system-index-block"/>

            <h1 id="title">
                <xsl:value-of select="$current-page/title"/> 
            </h1>

            <div class="contentBox">
                <xsl:comment>
                    Filtering to campus categories:
                    <xsl:for-each select="$news-categories">
                        <xsl:value-of select="."/>
                    </xsl:for-each>
                </xsl:comment>
                
                <ul class="archive-list">
                    <xsl:choose>
                    <!-- the following takes pages from the block that have categories matching the index page category. It excludes pages that have an element called "Category Index" which is how we exclude the index page itself from being matched. -->
                        <xsl:when test="$campus-index-block//system-page[name != 'index'][dynamic-metadata[starts-with(name,'category-') and value=$news-categories]] | $dept-index-block//system-page[name != 'index' and not(system-data-structure/page-type = 'Category Index')]">
                            <xsl:apply-templates select="$campus-index-block//system-page[name != 'index'][dynamic-metadata[starts-with(name,'category-') and value=$news-categories]] | $dept-index-block//system-page[name != 'index' and not(system-data-structure/page-type = 'Category Index')]">
                                <xsl:sort data-type="number" order="descending" select="ucsc:standardizePageDate(.)"/>
                            </xsl:apply-templates>
                        </xsl:when>
                        
                        <xsl:otherwise>
                            <p>This category does not currently have any articles to list.</p>
                        </xsl:otherwise>
                    </xsl:choose>
                </ul>    
            </div>            
        </xsl:template>
        
        <xsl:template match="system-page">
           <!-- alt tag variable conditions -->
           <xsl:variable name="alt-tag">
    <xsl:choose>
      <!-- used in News Article when UR News Lead Image Thumbnail alt tag is provided -->
      <xsl:when test="system-data-structure/lead-image/image-thumb-alt !=''">
                                  <xsl:value-of select="system-data-structure/lead-image/image-thumb-alt"/>
                         </xsl:when>
      <!-- could not find any instances when this condition is used -->
      <xsl:when test="system-data-structure/page/content/system-data-structure/lead-image/image-thumb-alt !=''">
                                  <xsl:value-of select="system-data-structure/page/content/system-data-structure/lead-image/image-thumb-alt"/>
                         </xsl:when>
      <!-- used in News Article Page, File, External Page (URL), Internal Page w/thumbnail, etc. -->
      <xsl:when test="system-data-structure/lead-image/image-alt !=''">
        <xsl:value-of select="system-data-structure/lead-image/image-alt"/>
      </xsl:when>
      <xsl:otherwise>No Image Alternative Tag Provided</xsl:otherwise>
    </xsl:choose>
    </xsl:variable>
        
            <li>
                <span class="date">
                <!-- here's the problem with dates: in the shortcut Content Type, you can select an article page and I would like the resulting link, image, summary, and date to come from that original article. Everything works right except the date which comes through as a string not in a system date format. I figured out how to display each by using the calling the format-date-string and format-date templates. However, I can't figure out how to sort the resulting articles by date since I have both types of dates. I could ask the users to input the date but I would rather pull it from the original article. -->      
                    <xsl:choose>
                        <xsl:when test="system-data-structure/page/path != '/'">
                         <xsl:call-template name="format-date-string">
          <xsl:with-param name="date" select="system-data-structure/page/start-date"/>
          <xsl:with-param name="mask">mmmm dd, yyyy</xsl:with-param>
        </xsl:call-template>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:call-template name="format-date">
                                <xsl:with-param name="date" select="start-date"/>
                                <xsl:with-param name="mask">mmmm d, yyyy</xsl:with-param> 
                            </xsl:call-template>  
                        </xsl:otherwise>
                    </xsl:choose>
                </span>
                
                <!-- 
                This section returns content from pages types that specify external URL, link to internal page, or link to file.  This section determines what type of link 
                it is (URL, Page, File).  In each case it then determines if there is a thumbnail to display.  In the case of the page, it also checks to see if 
                there is a thumbnail associated with the page (implies its a link to a news article) and returns that thumbnail.  If no thumbnail, uses one on the page if it 
                exists.  Uses the title and summary of the external page. -->
                
                <xsl:choose>
                 <!-- conditon for News Article (URL) - News Article Shortcut - External URL (External URL text contains URL) -->   
                    <xsl:when test="system-data-structure/external-url!=''">
                        <xsl:choose>
                            <xsl:when test="system-data-structure/lead-image/image-thumb/link != '/'">
                                <a href="{system-data-structure/external-url}">
                                    <img alt="{$alt-tag}" class="right" src="{system-data-structure/lead-image/image-thumb/link}"/> 
                                </a>
                                <h3><a href="{system-data-structure/external-url}">
                                    <xsl:value-of select="title"/>
                                </a></h3>
                                <p>
                                    <xsl:value-of select="summary"/>
                                </p>
                            </xsl:when>
                           <xsl:otherwise>
                               
                               <h3><a href="{system-data-structure/external-url}">
                                   <xsl:value-of select="title"/>
                               </a></h3>
                               <p>
                                   <xsl:value-of select="summary"/>
                               </p>
                           </xsl:otherwise> 
                        </xsl:choose>
                    </xsl:when>
                  
                  <!-- conditon for News Article (Page) - News Article Shortcut with Link to Local or Campus News Article -->
                    <xsl:when test="system-data-structure/page/path != '/'">
                        <xsl:choose>
                          <!-- conditon for News Article (Page) - News Article Shortcut - i.e. UR Campus News Article with thumbnail -->
                          <xsl:when test="system-data-structure/page/content/system-data-structure/lead-image/image-thumb/path !='/'">
                              <a href="{system-data-structure/page/link}">
                                  <img alt="{$alt-tag}" class="right" src="{system-data-structure/page/content/system-data-structure/lead-image/image-thumb/link}"/>
                              </a> 
                              <h3><a href="{system-data-structure/page/link}">
                                  <xsl:value-of select="system-data-structure/page/title"/>
                              </a> 
                              </h3>
                              <p>
                                  
                                  <xsl:value-of select="system-data-structure/page/summary"/> 
                              </p>
                          </xsl:when> 
                            
                            <!-- conditon for News Article (Page-External) - News Article Shortcut - Link to News Article with no thumbnail, and local/current site Lead Image Thumbnail provided -->
                            
                            <xsl:when test="system-data-structure/lead-image/image-thumb/link != '/'">
                               <a href="{system-data-structure/page/link}">
                                   <img alt="{$alt-tag}" class="right" src="{system-data-structure/lead-image/image-thumb/link}"/> 
                               </a>
                               <h3><a href="{system-data-structure/page/link}">
                                   <xsl:value-of select="system-data-structure/page/title"/>
                               </a>
                               </h3>
                               <p>
                                   <xsl:apply-templates select="system-data-structure/page/summary"/>
                               </p>
                            </xsl:when>
                            <!-- if no thumbnail at all -->
                            <xsl:otherwise>
                                <h3><a href="{system-data-structure/page/link}">
                                    <xsl:value-of select="system-data-structure/page/title"/>
                                </a></h3>
                                <p>
                                    <xsl:apply-templates select="system-data-structure/page/summary"/>
                                </p>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:when>
                    
                    <!-- conditon for News Article (File) - News Article Shortcut - Link to Internal File chosen, i.e. pdf -->
                              
                    <xsl:when test="system-data-structure/file/path != '/'">
                      <xsl:choose>
                          <xsl:when test="system-data-structure/lead-image/image-thumb/path != '/'"><a href="{system-data-structure/file/link}">
                              <img alt="{$alt-tag}" class="right" src="{system-data-structure/lead-image/image-thumb/link}"/> 
                          </a>
                              <h3><a href="{system-data-structure/file/link}">
                                  <xsl:value-of select="title"/>
                              </a></h3>
                              <p>
                                  <xsl:apply-templates select="summary"/>
                              </p>
                          </xsl:when>
                          <xsl:otherwise>
                              
                              <h3><a href="{system-data-structure/file/link}">
                                  <xsl:value-of select="title"/>
                              </a></h3>
                              <p>
                                  <xsl:apply-templates select="summary"/>
                              </p>
                          </xsl:otherwise>  
                      </xsl:choose>
                     
                    </xsl:when>
                    
                    <!-- conditon for News Article - if it has no External URL, page, or file and is therefore just a regular article -->  
                 
                    <xsl:otherwise>
                        <xsl:choose>
                            <xsl:when test="system-data-structure/lead-image/image-thumb/link != '/'">
                                <a href="{link}">
                                    <img alt="{$alt-tag}" class="right" src="{system-data-structure/lead-image/image-thumb/link}"/> 
                                </a>
                                <h3><a href="{link}">
                                    <xsl:value-of select="title"/>
                                </a></h3>
                                <p>
                                    <xsl:apply-templates select="summary"/>
                                </p>
                            </xsl:when>
                            <xsl:otherwise>
                                <h3>
                                    <a href="{link}"><xsl:value-of select="title"/></a>
                                </h3>
                                <p><xsl:value-of select="summary"/></p>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:otherwise> 
                </xsl:choose>
            </li>
        </xsl:template>
    </xsl:stylesheet>