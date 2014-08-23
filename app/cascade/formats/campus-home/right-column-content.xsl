<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output indent="yes" method="xml"/>
  
  <xsl:template match="/system-index-block">
    <xsl:apply-templates select="calling-page/system-page"/>
  </xsl:template>
  
  <xsl:template match="system-page">
    
    <!-- 
          We'll only include javascript functions if there are multiple images.
          Set the variable here $features and include js and functions 
          in the $slideshow variable below.
     -->
    <xsl:variable name="features">
      <xsl:choose>
        <xsl:when test="count(system-data-structure/feature/feature-image) &gt; 1">true</xsl:when>
        <xsl:otherwise>false</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    
    <xsl:variable name="slideshow">
      <!-- jQuery Carousel -->
      <script src="http://static.ucsc.edu/js/jquery.cycle.min.js" type="text/javascript"></script>
      <script src="http://static.ucsc.edu/js/jquery.tools.min.js" type="text/javascript"></script>
      <script type="text/javascript">  
        <![CDATA[
          $(function(){
              if ($('#features.true').hasClass('random') == false) {
                  
                        $('#features.true').cycle({
                          fx:'fade',
                          timeout:8000,
                          pager:'#bbnav',
                          pagerClick: function(){$('#features.true').cycle('pause');}
                          });
                    };  
                  $('#features.true.random').cycle({
                      fx:'fade',
                      random:1,
                      timeout:8000,
                      pager:'#bbnav',
                      pagerClick: function(){$('#billboard').cycle('pause');}
                      });   
            });
        ]]>
      </script>
    </xsl:variable>
    
    <xsl:if test="$features = 'true'">
      <xsl:copy-of select="$slideshow"/>
    </xsl:if>
    
    <!-- 
          Above content area: can be images or one block.
          IMAGES: placed in a js rotator using the jQuery Cycle plugin
          BLOCK: Same as feature block on news home page. Will override images.
    -->    
    <xsl:if test="system-data-structure/feature/feature-image/file/path != '/' or system-data-structure/feature/feature-block/path != '/'">
      <div id="above-content" class="content-box">
          <div class="inner">
            <xsl:choose>
              <!-- A block has been selected, so we'll place that here. -->
              <xsl:when test="system-data-structure/feature/feature-block/path != '/'">
                [system-view:internal]<!-- <div class="messages alert">Image slideshow does not show when a block has been selected. This message will not show when this page is published. :-)</div> -->[/system-view:internal]
                <xsl:if test="system-data-structure/feature/feature-block/content/system-data-structure/image/path != '/'">
                  <div class="image-box right">
                    <img alt="{system-data-structure/feature/feature-block/content/system-data-structure/image-alt}" src="{system-data-structure/feature/feature-block/content/system-data-structure/image/link}"/>
                    <!-- If the image is captioned, place the caption here. -->
                    <xsl:if test="system-data-structure/feature/feature-block/content/system-data-structure/feature-image-caption != ''">
                      <div class="caption">
                        <xsl:value-of select="system-data-structure/feature/feature-block/content/system-data-structure/feature-image-caption"/>
                      </div>                      
                    </xsl:if>
                  </div>
                </xsl:if>
                <xsl:if test="system-data-structure/feature/feature-block/content/system-data-structure/feature-story-link/title != ''">
                  <h2><xsl:value-of select="system-data-structure/feature/feature-block/content/system-data-structure/feature-story-link/title"/></h2>                  
                </xsl:if>
                <div class="description">
                  <xsl:copy-of select="system-data-structure/feature/feature-block/content/system-data-structure/feature-story-text/node()"/>
                  <xsl:if test="system-data-structure/feature/feature-block/content/system-data-structure/feature-story-link/link !='/'">
                    &#160;<a href="{system-data-structure/feature/feature-block/content/system-data-structure/feature-story-link/link}">More &#187;</a>
                  </xsl:if>
                </div>
              </xsl:when>

              <!-- No block has been selected, so there must be images. -->
              <xsl:otherwise>
                <div class="{$features}" id="features">
                  <xsl:for-each select="system-data-structure/feature/feature-image">
                    <div class="slide">
                      <xsl:choose>
                        <xsl:when test="url !=''">
                          <a href="{url}"><img alt="{alt-text}" src="{file/path}"/></a>
                        </xsl:when>
                        <xsl:otherwise>
                          <img alt="{alt-text}" src="{file/path}"/>
                        </xsl:otherwise>
                      </xsl:choose>
                    </div>
                  </xsl:for-each>      
                </div>
                <!-- Add navigation for slides -->
                <xsl:if test="$features = 'true'">
                  <div id="bbnav"></div>
                </xsl:if>
              </xsl:otherwise>
            </xsl:choose>
        </div> <!-- /.inner -->
      </div> <!-- /#above-content -->
    </xsl:if>
    
    <!-- Main content area. -->
    <xsl:if test="system-data-structure/main-column/content != ''">
      <div id="content" class="content-box">
        <xsl:copy-of select="system-data-structure/main-column/content/node()"/>       
      </div>
    </xsl:if>
    
  </xsl:template>

</xsl:stylesheet>