<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output indent="yes" method="xml"/> 

  <xsl:template match="/system-index-block">
    <xsl:apply-templates select="calling-page/system-page"/>
  </xsl:template>
  
  <xsl:template match="system-page">
 
    <!-- Grab the title value for string manipulation below. -->
    <xsl:variable name="landing-title">
        <xsl:value-of select="system-data-structure/title-content/title-text"/>
    </xsl:variable>

    <!-- Add non-breaking space between two words to keep it all on one line. -->
    <xsl:variable name="headline" select="concat(substring-before($landing-title, ' '), '&#xA0;' ,substring-after($landing-title, ' '))"/>
 
    <!-- Now we can print the title. -->
    <div class="title-group">
      <h1><xsl:value-of select="$headline"/></h1>
      <p><xsl:value-of select="system-data-structure/title-content/title-tagline"/></p>
    </div>
  </xsl:template>
  
</xsl:stylesheet>