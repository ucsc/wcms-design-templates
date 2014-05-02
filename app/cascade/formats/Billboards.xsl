<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes" method="xml" omit-xml-declaration="yes"/>

  <xsl:template match="/system-index-block">
    <div class="owl-carousel" id="slides">
      <xsl:apply-templates select="calling-page/system-page/system-data-structure/billboards"/>
    </div>
  </xsl:template>

  <xsl:template match="billboards">
  <div class="slide">
    <!-- If there is a headline and teaser, we use the new style -->
    <xsl:if test="headline != '' and teaser != ''">
      <!-- <xsl:variable name="layout-class" select="layout"></xsl:variable> -->
      <div class="slide-body">
        <xsl:attribute name="class">slide-body <xsl:value-of select="layout"/></xsl:attribute>
        <h1><xsl:value-of select="headline"/></h1>
        <p><xsl:value-of select="teaser"/></p>
        <!-- Depending on the URL (internal, symlink, or external), we change the href. -->
        <xsl:if test="link-text != ''">
          <xsl:choose>
            <xsl:when test="page/path != '/'">
              <a href="{page/link}"><xsl:value-of select="link-text"/></a>
            </xsl:when>
            <xsl:when test="symlink/path != '/'">
              <a href="{symlink/path}"><xsl:value-of select="link-text"/></a>
            </xsl:when>        
            <xsl:otherwise>  
              <a href="{url}"><xsl:value-of select="link-text"/></a>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:if>
      </div>
      <img alt="{alt-text}" src="{image/path}" width="780"/>
    </xsl:if>
    
    <!-- If the headline and teaser are absent, we use the old style. [DEPRECATE] -->
    <xsl:if test="headline = '' and teaser = ''">
      <xsl:choose>
        <xsl:when test="page/path != '/'">
          <a href="{page/link}"><img alt="{alt-text}" src="{image/path}" width="780"/></a>
        </xsl:when>
        <xsl:when test="symlink/path != '/'">
          <a href="{symlink/path}"><img alt="{alt-text}" src="{image/path}" width="780"/></a>
        </xsl:when>
        <xsl:when test="url != ''">  
          <a href="{url}"><img alt="{alt-text}" src="{image/path}" width="780"/></a>
        </xsl:when>        
        <xsl:otherwise>  
          <img alt="{alt-text}" src="{image/path}" width="780"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>
    
  </div> 
  </xsl:template>
  
</xsl:stylesheet>