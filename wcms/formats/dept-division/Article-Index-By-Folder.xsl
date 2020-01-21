<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output indent="yes" method="xml"/> 
  <xsl:include href="/formats/Format Date"/>

  <xsl:variable name="current-date" select="//system-index-block/@current-time"/>
  
  <xsl:template match="/system-index-block">
    <h1 id="title">
      <!-- New improved code CRT WEB-230 -->
      <xsl:value-of select="calling-page/system-page/title"/> 
      <!-- previous code
      <xsl:value-of select="//system-folder[@current]/title"/>
      -->
      <!-- 1st rendition of code ???
      &#032;
      <xsl:value-of select="//system-folder[system-folder[@current and not(@reference)]]/title"/> 
      -->
    </h1>
    <div class="content-box">
      <ul class="archive-list">
      <xsl:apply-templates select="//system-folder[@current and not(ancestor::system-data-structure)]/system-page[name != 'index']">
        <xsl:sort data-type="number" order="descending" select="system-data-structure/article-date"/>
        <xsl:sort data-type="number" order="descending" select="start-date"/>
      </xsl:apply-templates>
      </ul>    
    </div>  
  </xsl:template>

  <xsl:template match="system-page">
    <!-- display "alt-tag" with variable plus condition when image alt text is not provided -->
    <xsl:variable name="alt-tag">
      <xsl:choose>
        <xsl:when test="system-data-structure/lead-image/image-alt !=''">
          <xsl:value-of select="system-data-structure/lead-image/image-alt"/> 
        </xsl:when>
        <xsl:otherwise>No Image Alternative Tag Provided</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <li>      
      <span class="date">
        <xsl:call-template name="format-date">
          <xsl:with-param name="date" select="start-date"/>
          <xsl:with-param name="mask">mmmm d, yyyy</xsl:with-param> 
        </xsl:call-template>
      </span>
      
      <!-- conditions to display article (with image or not) includes "alt-tag" variable when image alt text is not provided -->
      <xsl:choose>
        <xsl:when test="system-data-structure/lead-image/image-thumb/link != '/'">
          <a href="{link}">
            <img alt="{$alt-tag}" class="right" src="{system-data-structure/lead-image/image-thumb/path}"/>
          </a>
          <h3><a href="{link}">
            <xsl:value-of select="title"/>
          </a></h3>
          <p>
            <xsl:apply-templates select="summary"/>
          </p>
        </xsl:when>
        
        <xsl:otherwise>
          <h3><a href="{path}">
            <xsl:value-of select="title"/>
          </a></h3>
          <p><xsl:value-of select="summary"/></p>
        </xsl:otherwise>
        
      </xsl:choose>
    </li>
  </xsl:template>
<!--  
  <xsl:template match="summary">
      <xsl:call-template name="firstWords">
        <xsl:with-param name="value" select="."/>
        <xsl:with-param name="count" select="28"/>
      </xsl:call-template>
    </xsl:template>

    <xsl:template name="firstWords">
      <xsl:param name="value"/>
      <xsl:param name="count"/>

      <xsl:if test="number($count) >= 1">
        <xsl:value-of select="concat(substring-before($value,' '),' ')"/>
      </xsl:if>
      <xsl:if test="number($count) > 1">
        <xsl:variable name="remaining" select="substring-after($value,' ')"/>
        <xsl:if test="string-length($remaining) > 0">
          <xsl:call-template name="firstWords">
            <xsl:with-param name="value" select="$remaining"/>
            <xsl:with-param name="count" select="number($count)-1"/>
          </xsl:call-template>
        </xsl:if>
      </xsl:if>
    </xsl:template>
    
    -->

</xsl:stylesheet>