<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output indent="yes" method="xml" omit-xml-declaration="yes"/>
  <xsl:include href="/formats/Format Date"/>

<!--
Pattern for future block types:
[begin example]

<xsl:template match="*[content/system-data-structure/IDENTIFIER_IN_SD_BLOCK]" mode="homepage-block">
... content to render from block ...
LIKE: <xsl:value-of select="content/system-data-structure/IDENTIFIER_IN_SD_BLOCK/..." />
</xsl:template>

[end example]
-->

<!-- March 2011 updates:  
add youtube video block
add calendar block
set slideshow blocks to 72x72
add logic to news article to handle new article shortcut
-->

<!-- NEWS ARTICLES -->
<xsl:template match="*[content/system-data-structure/articles]" mode="homepage-block">
  <div id="news">
    <!-- Block title -->
    <h3>
      <xsl:value-of select="content/system-data-structure/articles/title1"/><xsl:if test="content/system-data-structure/articles/title2 !=''">&#160;<span><xsl:value-of select="content/system-data-structure/articles/title2"/></span></xsl:if>
    </h3>
    
    <div class="inner">
      <ul>
        <!-- height variable test to set image height to 48 pixels if more than 2 news item shown, otherwise set image height to 80  -->
        <xsl:variable name="height">     
          <xsl:choose>
            <xsl:when test="count(content/system-data-structure/articles/article) &gt; 2">48</xsl:when>
            <xsl:otherwise>80</xsl:otherwise>  
          </xsl:choose>
        </xsl:variable>

        <xsl:for-each select="content/system-data-structure/articles/article">

          <xsl:variable name="alt-tag">
            <xsl:choose>
              <xsl:when test="content/system-data-structure/lead-image/image-alt !=''">
                <xsl:value-of select="content/system-data-structure/lead-image/image-alt"/>
              </xsl:when>
              <xsl:when test="content/system-data-structure/lead-image/image-thumb-alt !=''">
                <xsl:value-of select="content/system-data-structure/lead-image/image-thumb-alt"/>
              </xsl:when>
              <xsl:when test="content/system-data-structure/page/content/system-data-structure/lead-image/image-thumb-alt !=''">
                <xsl:value-of select="content/system-data-structure/page/content/system-data-structure/lead-image/image-thumb-alt"/>
              </xsl:when>
              <xsl:otherwise>No Image Alternative Tag Provided</xsl:otherwise>
            </xsl:choose>
          </xsl:variable>

          <li>

            <xsl:choose>

              <!--  
                  Condition for News Article (URL)
                  News Article Shortcut - External URL (External URL text contains URL)
               -->   
              <xsl:when test="content/system-data-structure/external-url!=''">
                          
                <a href="{content/system-data-structure/external-url}">
                
                    <xsl:if test="content/system-data-structure/lead-image/image-thumb/link != '/'">  
                      <span class="thumbnail">
                        <img alt="{$alt-tag}" class="fltlft" height="{$height}" src="{content/system-data-structure/lead-image/image-thumb/link}"/>
                      </span>
                    </xsl:if>

                      <span class="date">
                        <xsl:call-template name="format-date-string">
                          <xsl:with-param name="date" select="start-date"/>
                          <xsl:with-param name="mask">mmmm d, yyyy</xsl:with-param> 
                        </xsl:call-template>  
                      </span>

                      <span class="headline">
                        <xsl:value-of select="title"/>
                      </span>

                </a>
                    
              </xsl:when>

              <!--
                  Condition for News Article (Page)
                  News Article Shortcut with Link to Local or Campus News Article
               -->

              <xsl:when test="content/system-data-structure/page/path != '/'">
                         
                    <a href="{content/system-data-structure/page/link}">

                    <xsl:if test="content/system-data-structure/lead-image/image-thumb/link != '/'">  
                      <span class="thumbnail">
                        <img alt="{$alt-tag}" class="fltlft" height="{$height}" src="{content/system-data-structure/lead-image/image-thumb/link}"/>
                      </span>
                    </xsl:if>

                      <span class="date">
                        <xsl:call-template name="format-date-string">
                          <xsl:with-param name="date" select="start-date"/>
                          <xsl:with-param name="mask">mmmm d, yyyy</xsl:with-param> 
                        </xsl:call-template>  
                      </span>

                      <span class="headline">
                        <xsl:value-of select="title"/>
                      </span>                 

                    </a>

              </xsl:when> 

              


              <!-- 
                  Condition for News Article (File)
                  News Article Shortcut - Link to Internal File chosen, i.e. pdf
              -->           

              <xsl:when test="content/system-data-structure/file/path != '/'">
                

                    <a href="{content/system-data-structure/file/link}">

                      <span class="thumbnail">
                        <img alt="{$alt-tag}" class="fltlft" height="{$height}" src="{content/system-data-structure/lead-image/image-thumb/link}"/>
                      </span>

                      <span class="date">
                        <xsl:call-template name="format-date-string">
                          <xsl:with-param name="date" select="start-date"/>
                          <xsl:with-param name="mask">mmmm d, yyyy</xsl:with-param> 
                        </xsl:call-template>  
                      </span>

                      <span class="headline">
                        <xsl:value-of select="title"/>
                      </span>   

                    </a>
  
              </xsl:when>

            <!-- 
                Condition for News Article
                if it has no External URL, page, or file and is therefore just a regular article
            -->  

            <xsl:otherwise>

                  <a href="{link}">

                      <span class="thumbnail">
                        <img alt="{$alt-tag}" class="fltlft" height="{$height}" src="{content/system-data-structure/lead-image/image-thumb/link}"/>
                      </span>

                      <span class="date">
                        <xsl:call-template name="format-date-string">
                          <xsl:with-param name="date" select="start-date"/>
                          <xsl:with-param name="mask">mmmm d, yyyy</xsl:with-param> 
                        </xsl:call-template>  
                      </span>

                      <span class="headline">
                        <xsl:value-of select="title"/>
                      </span>   

                  </a>
                
            </xsl:otherwise> 
          </xsl:choose>
        </li>

      </xsl:for-each>
      
      <xsl:if test="content/system-data-structure/articles/news-index/path !='/'">
        <li><em><a href="{content/system-data-structure/articles/news-index/link}" title="More">More...</a></em></li>
      </xsl:if>

    </ul>
  </div>
</div>
</xsl:template>

<!-- FEATURED PROFILE -->

<xsl:template match="*[content/system-data-structure/profile]" mode="homepage-block">
  <div id="profile">
    <h3><xsl:value-of select="content/system-data-structure/profile/title1"/><xsl:if test="content/system-data-structure/profile/title2 !=''">&#160;<span><xsl:value-of select="content/system-data-structure/profile/title2"/></span></xsl:if></h3>
    <div class="inner">

      <!-- Is there a thumbnail assigned in the SD block? -->
      <xsl:if test="content/system-data-structure/profile/profile/content/system-data-structure/lead-image/image-thumb/link">
        <xsl:choose>
          <xsl:when test="content/system-data-structure/profile/profile/content/system-data-structure/lead-image/image-alt != ''">
            <img alt="{content/system-data-structure/profile/profile/content/system-data-structure/lead-image/image-alt}" src="{content/system-data-structure/profile/profile/content/system-data-structure/lead-image/image-thumb/link}"/>
          </xsl:when>
          <xsl:otherwise>
            <img alt="No Image Alternative Tag Provided" src="{content/system-data-structure/profile/profile/content/system-data-structure/lead-image/image-thumb/link}"/>
          </xsl:otherwise>
        </xsl:choose>   
      </xsl:if>

      <a class="upTitle" href="{content/system-data-structure/profile/profile/link}">
        <xsl:value-of select="content/system-data-structure/profile/profile/title"/><br/>       
      </a>
      <p>
        <xsl:value-of select="content/system-data-structure/profile/profile/summary"/>
        <a class="continu" href="{content/system-data-structure/profile/profile/link}">
          Continue&#187;
        </a>
      </p>    
    </div>
  </div>
</xsl:template>

<!--SLIDESHOW BLOCK -->
<xsl:template match="*[content/system-data-structure/slideshow]" mode="homepage-block">
  <div id="view">
    <h3><xsl:value-of select="content/system-data-structure/slideshow/title1"/><xsl:if test="content/system-data-structure/slideshow/title2 !=''">&#160;<span><xsl:value-of select="content/system-data-structure/slideshow/title2"/></span></xsl:if></h3>
    <div class="inner">
      <xsl:for-each select="content/system-data-structure/slideshow/slide[image[link!='/']]">
        <a href="{image/link}" rel="lightbox" title="{alt}">
          <img alt="{alt}" height="72" src="{thumb/link}" width="72"/>
        </a>
      </xsl:for-each>
    </div>
  </div>
</xsl:template>

<!-- TEXT BLOCK -->
<xsl:template match="*[content/system-data-structure/text-block]" mode="homepage-block">
  <div id="forstudents">
    <h3><xsl:value-of select="content/system-data-structure/text-block/title1"/><xsl:if test="content/system-data-structure/text-block/title2 !=''">&#160;<span><xsl:value-of select="content/system-data-structure/text-block/title2"/></span></xsl:if></h3>
    <div class="inner">

      <xsl:copy-of select="content/system-data-structure/text-block/text/node()"/>

    </div>
  </div>
</xsl:template>

<!-- CALENDAR BLOCK -->
<xsl:template match="*[content/system-data-structure/calendar]" mode="homepage-block">

  <div id="events">
    <h3><xsl:value-of select="content/system-data-structure/calendar/title1"/><xsl:if test="content/system-data-structure/calendar/title2 !=''">&#160;<span><xsl:value-of select="content/system-data-structure/calendar/title2"/></span></xsl:if></h3>
    <div class="inner">
      <dl>
        <xsl:for-each select="content/system-data-structure/calendar/event">
          <dt><xsl:value-of select="month"/>&#160;<strong><xsl:value-of select="day"/></strong>
        </dt>
        <dd>
          <xsl:choose>
            <xsl:when test="url !=''">
              <a href="{url}"><xsl:value-of select="name"/></a>
            </xsl:when>
            <xsl:when test="page/path !='/'">
              <a href="{page/link}"><xsl:value-of select="name"/></a>
            </xsl:when>
            <xsl:when test="file/path !='/'">
              <a href="{file/link}"><xsl:value-of select="name"/></a>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="name"/>
            </xsl:otherwise>
          </xsl:choose>
        </dd>
      </xsl:for-each>
      <div class="clear-both"></div>
      <xsl:if test="content/system-data-structure/calendar/more/path !='/'">
        <em><a href="{content/system-data-structure/calendar/more/link}" title="More">More...</a></em>
        
      </xsl:if>

    </dl>
    
  </div>
</div>
</xsl:template>

<!-- YOUTUBE VIDEO BLOCK -->
<xsl:template match="*[content/system-data-structure/youtube]" mode="homepage-block">

  <div id="video">
    <h3><xsl:value-of select="content/system-data-structure/youtube/title1"/><xsl:if test="content/system-data-structure/youtube/title2 !=''">&#160;<span><xsl:value-of select="content/system-data-structure/youtube/title2"/></span></xsl:if></h3>
    
    <div class="inner">
      <xsl:if test="content/system-data-structure/youtube/video_thumb/link != '/'">
        <xsl:if test="content/system-data-structure/youtube/video_url">
          <a class="fb thumb_link" href="{content/system-data-structure/youtube/video_url}">
            <img alt="Play button" class="play_btn" height="35" src="site://static/images/play_btn.png" width="48"/>
            <img alt="YouTube video thumbnail" height="90" src="{content/system-data-structure/youtube/video_thumb/link}" width="216"/>
          </a>
        </xsl:if>
      </xsl:if>
      <xsl:if test="content/system-data-structure/youtube/video_thumb/link = '/'">
        <img alt="YouTube video thumbnail" src="{content/system-data-structure/youtube/video_thumb/link}" width="216"/>
      </xsl:if>
      <xsl:if test="content/system-data-structure/youtube/video_title">
        <a class="fb upTitle" href="{content/system-data-structure/youtube/video_url}">
          <xsl:value-of select="content/system-data-structure/youtube/video_title"/>
        </a>
      </xsl:if>
      <xsl:if test="content/system-data-structure/youtube/video_description">
        <p>
          <xsl:copy-of select="content/system-data-structure/youtube/video_description/node()"/>
          <xsl:if test="content/system-data-structure/youtube/video_url">&#160;<a class="fb continu" href="{content/system-data-structure/youtube/video_url}">Watch&#187;</a>
        </xsl:if>
      </p>
    </xsl:if>
  </div>
</div>
</xsl:template>


<xsl:template match="*[content[not(system-data-structure) and count(node()) &gt; 0]]" mode="homepage-block">
  <xsl:copy-of select="content/node()"/>
</xsl:template>

<!-- Catch any system-data-structure blocks that are not defined above -->
<xsl:template match="*[content/system-data-structure]" mode="homepage-block" priority="-10">
  [system-view:internal]<h3>INVALID BLOCK TYPE</h3><div class="inner">Invalid Block Type</div>[/system-view:internal]
  [system-view:external]<h3><xsl:value-of select="ancestor::calling-page/system-page/display-name"/></h3><div class="inner"><xsl:value-of select="ancestor::calling-page/system-page/summary"/></div>[/system-view:external]
</xsl:template>

</xsl:stylesheet>