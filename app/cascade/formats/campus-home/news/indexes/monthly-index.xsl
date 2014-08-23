<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output indent="yes" method="xml"/> 
  <xsl:include href="/formats/Format Date"/>

  <xsl:variable name="current-date" select="//system-index-block/@current-time"/>
  
  <!-- Template for the page. -->
  <xsl:template match="/system-index-block">
    
    <!-- If there is a title, print it. -->
    <xsl:if test="//system-folder[@current]/title">
      <h1 id="title">
        <xsl:value-of select="//system-folder[@current]/title"/>&#032;
        <xsl:value-of select="//system-folder[system-folder[@current and not(@reference)]]/title"/> News Archive
      </h1>
    </xsl:if>
    
    <div class="content-box">
      <ul class="archive-list image-right item-border">
      <xsl:apply-templates select="//system-folder[@current and not(ancestor::system-data-structure)]/system-page[name != 'index']">
        <xsl:sort data-type="number" order="descending" select="system-data-structure/article-date"/>
        <xsl:sort data-type="number" order="descending" select="start-date"/>
      </xsl:apply-templates>
      </ul>    
    </div>  
  
  </xsl:template>

  <xsl:template match="system-page">
    <li>           
      <!-- Image, if there is one -->
      <xsl:if test="system-data-structure/lead-image/image-thumb/link != '/'">
        <a href="{link}">
          <img alt="{system-data-structure/lead-image/image-thumb/display-name}" class="thumbnail" src="{system-data-structure/lead-image/image-thumb/path}"/>
        </a>
      </xsl:if>
                  
      <!-- Date -->
      <span class="date">
        <xsl:call-template name="format-date">
        <xsl:with-param name="date" select="start-date"/>
        <xsl:with-param name="mask">mmmm d, yyyy</xsl:with-param> 
        </xsl:call-template>
      </span>

      <!-- Title -->
      <h3>
        <a href="{link}"><xsl:value-of select="title"/></a>
      </h3>
      
      <!-- Summary -->
      <p class="description">
        <xsl:apply-templates select="summary"/>
      </p>

    </li>
  </xsl:template>
  
  <xsl:template match="summary">
      <xsl:call-template name="firstWords">
        <xsl:with-param name="value" select="."/>
        <xsl:with-param name="count" select="28"/>
      </xsl:call-template>
    </xsl:template>

    <xsl:template name="firstWords">
      <xsl:param name="value"/>
      <xsl:param name="count"/>

      <xsl:if test="number($count) &gt;= 1">
        <xsl:value-of select="concat(substring-before($value,' '),' ')"/>
      </xsl:if>
      <xsl:if test="number($count) &gt; 1">
        <xsl:variable name="remaining" select="substring-after($value,' ')"/>
        <xsl:if test="string-length($remaining) &gt; 0">
          <xsl:call-template name="firstWords">
            <xsl:with-param name="value" select="$remaining"/>
            <xsl:with-param name="count" select="number($count)-1"/>
          </xsl:call-template>
        </xsl:if>
      </xsl:if>
    </xsl:template>

</xsl:stylesheet>