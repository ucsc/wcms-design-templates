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

    
    <!-- Now we can print the title. -->
    <div class="title-group">
    
    <!-- When there are two words, add a non-breaking space between them. Otherwise, don't. -->      
    <xsl:choose>
      <xsl:when test="contains($landing-title, ' ')">        
        <h1>
          <xsl:value-of select="concat(substring-before($landing-title, ' '), '&#xA0;' ,substring-after($landing-title, ' '))"/>
        </h1>
      </xsl:when>
      <xsl:otherwise>
          <h1><xsl:value-of select="$landing-title"/></h1>
      </xsl:otherwise>
    </xsl:choose>
          <p><xsl:value-of select="system-data-structure/title-content/title-tagline"/></p>
    </div>
  </xsl:template>
  
</xsl:stylesheet>