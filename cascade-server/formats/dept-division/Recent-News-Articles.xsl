<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xmlns:func="http://exslt.org/functions" xmlns:hh="http://www.hannonhill.com/XSL/Functions" xmlns:ucsc="http://ucsc.edu/xslt/functions">
     
     <!-- This format creates an index page that combines content from a specific local folder with content from an index of the most recent 200 articles from another site (the main campus news source). The block is a structured data block that combines the the two types of index blocks.
          The local folder can contain two different content types: one is a regular news article and the other is a news article shortcut. They share basic metadata and thumbnail but the shortcut otherwise is just a page, URL, or file chooser.  -->   
        
        <xsl:output indent="yes" method="xml"/> 
      <xsl:include href="/formats/Format Date"/>
        
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
        
        <xsl:variable name="current-page" select="system-index-block/calling-page/system-page"/>
        <xsl:variable name="current-date" select="system-index-block/@current-time"/>

        <xsl:template match="system-index-block">

            <h1 id="title">
                <xsl:value-of select="$current-page/title"/> 
            </h1>

            <div>
                <ul class="archive-list">
                     <xsl:apply-templates select="//system-page[name != 'index']">
                                <xsl:sort data-type="number" order="descending" select="ucsc:standardizePageDate(.)"/>
                     </xsl:apply-templates>
                </ul>    
            </div>            
        </xsl:template>

        <xsl:template match="system-page">
            
            <xsl:variable name="alt-tag">
      <xsl:choose>
        
        <xsl:when test="system-data-structure/page/content/system-data-structure/lead-image/image-thumb-alt !=''">
                                    <xsl:value-of select="system-data-structure/page/content/system-data-structure/lead-image/image-thumb-alt"/>
                           </xsl:when>
        
        <xsl:when test="system-data-structure/lead-image/image-alt !=''">
          <xsl:value-of select="system-data-structure/lead-image/image-alt"/> 
        </xsl:when>
        <xsl:otherwise>No Image Alternative Tag Provided</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    
    
      <xsl:if test="position() &lt;= 20"> 
            <li>
                <span class="date">
                       
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
                 <!-- conditon for News Article (URL) - News Article Shortcut - External URL (External URL text box contains URL) -->   
                    <xsl:when test="system-data-structure/external-url!=''">
                        <xsl:choose>
                            <xsl:when test="system-data-structure/lead-image/image-thumb/link != '/'">
                                <a href="{system-data-structure/external-url}">
                                    <!-- <img alt="{system-data-structure/lead-image/alt}" class="right" src="{system-data-structure/lead-image/image-thumb/link}"/> -->
                                    <img alt="{$alt-tag}" class="right" src="{system-data-structure/lead-image/image-thumb/link}"/>
                                </a>
                                <h3><a href="{system-data-structure/external-url}">
                                    <xsl:value-of select="title"/>
                                </a></h3>
                                <p>
                                    <xsl:value-of select="summary"/>
                                </p>
                            </xsl:when>
                            <!-- condition for no image -->
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
                                  <!-- <img alt="{system-data-structure/page/content/system-data-structure/lead-image/image-thumb/display-name}" class="right" src="{system-data-structure/page/content/system-data-structure/lead-image/image-thumb/link}"/> -->
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
                                   <!-- <img alt="{system-data-structure/lead-image/alt}" class="right" src="{system-data-structure/lead-image/image-thumb/link}"/> -->
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
                            <!-- condition for no image -->
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
                          <xsl:when test="system-data-structure/lead-image/image-thumb/link != '/'"><a href="{system-data-structure/file/path}">
                              <!-- <img alt="{system-data-structure/lead-image/alt}" class="right" src="{system-data-structure/lead-image/image-thumb/link}"/> -->
                              <img alt="{$alt-tag}" class="right" src="{system-data-structure/lead-image/image-thumb/link}"/>
                          </a>
                              <h3><a href="{system-data-structure/file/path}">
                                  <xsl:value-of select="title"/>
                              </a></h3>
                              <p>
                                  <xsl:apply-templates select="summary"/>
                              </p>
                          </xsl:when>
                          <!-- condition for no image -->
                          <xsl:otherwise>
                              <h3><a href="{system-data-structure/file/path}">
                                  <xsl:value-of select="title"/>
                              </a></h3>
                              <p>
                                  <xsl:apply-templates select="summary"/>
                              </p>
                          </xsl:otherwise>  
                      </xsl:choose>
                    </xsl:when> 
                 
                    <!-- conditon for News Article - if it has no link to External URL, Page, or File and is therefore just a regular article -->
                    
                    <xsl:otherwise>
                        <xsl:choose>
                            <xsl:when test="system-data-structure/lead-image/image-thumb/link != '/'">
                                <a href="{link}">
                                    <!-- <img alt="{system-data-structure/lead-image/alt}" class="right" src="{system-data-structure/lead-image/image-thumb/link}"/> -->
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
           
            </xsl:if>
        </xsl:template>
    </xsl:stylesheet>