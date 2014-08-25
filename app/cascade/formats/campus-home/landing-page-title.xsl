<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output indent="yes" method="xml"/> 

  <xsl:template match="/system-index-block">
    <xsl:apply-templates select="calling-page/system-page"/>
  </xsl:template>
  
  <xsl:template match="system-page">
    <div class="title-group">
      <h1><xsl:value-of select="system-data-structure/title-content/title-text"/></h1>
      <p><xsl:value-of select="system-data-structure/title-content/title-tagline"/></p>
    </div>
  </xsl:template>
  
</xsl:stylesheet>