<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output indent="yes" method="xml"/>
  
  <xsl:template match="/system-index-block">
    <xsl:apply-templates select="calling-page/system-page"/>
  </xsl:template>
  
  <xsl:template match="system-page">
    
    <!-- Set the variable $features -->
    <xsl:variable name="features">
      <xsl:choose>
        <xsl:when test="count(system-data-structure/feature/feature-image) &gt; 1">true</xsl:when>
        <xsl:otherwise>false</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <!-- Set the variable for $random (for random image order) -->
    <xsl:variable name="random">
      <xsl:choose>
        <xsl:when test="system-data-structure/feature/random-order = 'Yes'">random</xsl:when>
        <xsl:otherwise>not-random</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    
    <xsl:variable name="alt-tag">
        <xsl:choose>
            <xsl:when test="system-data-structure/feature/feature-image/alt-text !=''">
                <xsl:value-of select="system-data-structure/feature/feature-image/alt-text"/>
            </xsl:when>
            <xsl:otherwise>No alternative text.</xsl:otherwise>
        </xsl:choose>
   </xsl:variable>
      

    <!-- Billboards -->        
    <xsl:if test="system-data-structure/feature/feature-image/file/path != '/'">
      
      <div id="carousel">

      <div class="owl-carousel {$features} {$random}" id="slides">
                  
        <xsl:for-each select="system-data-structure/feature/feature-image">

          <div class="slide">
            
            <xsl:choose>
        
              <xsl:when test="page/path !='/'">
                <a href="{page/link}"><img alt="{$alt-tag}" src="{file/link}" width="568"/></a>
              </xsl:when>
              
              <xsl:when test="symlink/path !='/'">
                <a href="{symlink/path}"><img alt="{$alt-tag}" src="{file/link}" width="568"/></a>
              </xsl:when>
              
              <xsl:when test="url !=''">
                <a href="{url}"><img alt="{$alt-tag}" src="{file/link}" width="568"/></a>
              </xsl:when>
                                                 
              <xsl:otherwise>
                <img alt="{$alt-tag}" src="{file/link}" width="568"/>
              </xsl:otherwise>
            
            </xsl:choose> 
          
          </div> <!-- /.slide -->
        
        </xsl:for-each>      
               
      </div> <!-- /#slides -->

      </div> <!-- /#carousel --> 

    </xsl:if>
    
    <!-- Main content -->
    <xsl:if test="system-data-structure/main-content/. != ''">
      <div id="content" class="contentBox">
        <xsl:copy-of select="system-data-structure/main-content/content/node()"/>        
      </div>
    </xsl:if>
    
  </xsl:template>

</xsl:stylesheet>