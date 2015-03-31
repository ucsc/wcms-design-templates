<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output indent="yes" method="xml"/> 

  <xsl:template match="/system-index-block">
    <xsl:apply-templates select="calling-page/system-page/system-data-structure/main"/>
  </xsl:template>
  
  <xsl:template match="main">
    <div>
      <xsl:choose>
        <xsl:when test="page/path != '/'">
          <a href="{page/path}">
            <img alt="{image_alt}" src="{image/path}"/>
          </a>
        </xsl:when>
        <xsl:when test="symlink/path != '/'">
          <a href="{symlink/path}">
            <img alt="{image_alt}" src="{image/path}"/>
          </a> 
        </xsl:when>        
        <xsl:otherwise>  
          <a href="{url}">
            <img alt="{image_alt}" src="{image/path}"/>
          </a>
        </xsl:otherwise>
      </xsl:choose>
      
      <xsl:choose>
        <xsl:when test="page/path != '/'">
          <h2><a href="{page/path}">
            <xsl:value-of select="title"/>
          </a></h2>
        </xsl:when>
        <xsl:when test="symlink/path != '/'">
          <h2><a href="{symlink/path}">
            <xsl:value-of select="title"/>
          </a></h2>
        </xsl:when>
        <xsl:otherwise>
          <h2><a href="{url}">
            <xsl:value-of select="title"/>
          </a></h2>
        </xsl:otherwise>
      </xsl:choose>
      
      <p><xsl:value-of select="abstract"/></p>
    </div>

  </xsl:template>
</xsl:stylesheet>