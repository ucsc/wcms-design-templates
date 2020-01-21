<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes" method="xml" omit-xml-declaration="yes"/>
<xsl:include href="/formats/Format Date"/>





<xsl:template match="system-index-block/calling-page/system-page">
  
  <!-- Check for the presence of a title -->
  <xsl:if test="title">
    <h1 id="title">
      <xsl:value-of select="title"/>
    </h1>
  </xsl:if>

  <div class="contentBox">
    <xsl:for-each select="system-data-structure/intro">
      <xsl:if test=". != ''">
        <div>
         <xsl:copy-of select="node()"/>
        </div>
      </xsl:if>
    </xsl:for-each>

    <p>
      <xsl:for-each select="calling-page/system-page/system-data-structure/content[node()]"/>
    </p>

    <ul class="thumb-grid">
      <xsl:apply-templates select="system-data-structure/slideshow"/>
    </ul>
  </div>

</xsl:template>

<xsl:template match="system-data-structure/slideshow">  
  
      <xsl:for-each select="slide[image[link!='/']]">
        <li>
          <a href="{image/link}" rel="show" title="{caption}">
            <img alt="{image-alt}" height="86" src="{thumb/link}" width="120"/>
          </a>
        </li>
      </xsl:for-each>
    
</xsl:template>

</xsl:stylesheet>