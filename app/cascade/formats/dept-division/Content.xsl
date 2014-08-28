<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes" method="xml"/>
<xsl:include href="/formats/content-pages/related-links"/>
<xsl:template match="/system-index-block">
<xsl:apply-templates select="calling-page/system-page"/>
</xsl:template>

<xsl:template match="system-page">
  <!-- Test for a page title before outputting the <h1> -->
  <xsl:if test="title">
    <h1 class="page-title" id="title">
      <xsl:value-of select="title"/>
    </h1>
  </xsl:if>
  
  <!-- Display image, image alternative text, and caption -->
  <xsl:if test="system-data-structure/banner/image/path != '/'">
    <div class="banners bannerBox" id="bannerBox">
      <xsl:choose>
        <xsl:when test="system-data-structure/banner/image-alt != ''">
          <img alt="{system-data-structure/banner/image-alt}" id="banner" src="{system-data-structure/banner/image/path}"/>
        </xsl:when>
        <xsl:when test="system-data-structure/banner/caption != '' and system-data-structure/banner/image-alt = ''">
          <img alt="Banner photo, caption follows." id="banner" src="{system-data-structure/banner/image/path}"/>
          <p class="caption">
            <xsl:value-of select="system-data-structure/banner/caption"/>
          </p>
        </xsl:when>        
        <xsl:otherwise>
          <img alt="Banner photo with no alternative text" id="banner" src="{system-data-structure/banner/image/path}"/>
        </xsl:otherwise>
      </xsl:choose>
    </div>
  </xsl:if>

  <!-- Display the page content -->
  <xsl:for-each select="system-data-structure/content">
    <xsl:if test=". != ''">
      <div class="content contentBox">
        <xsl:copy-of select="node()"/>
      </div>
    </xsl:if>
  </xsl:for-each>

  <!-- Display the associated links, if they are there. -->
  <xsl:if test="system-data-structure/links/page/path != '/' or system-data-structure/links/symlink/path != '/' or system-data-structure/url != 'http://'">
    <h3>See <span>Also</span></h3>
      <div id="seeAlso">
        <ul>
          <xsl:apply-templates select="system-data-structure/related-links"/>
        </ul>
      </div>
  </xsl:if>

</xsl:template>
</xsl:stylesheet>