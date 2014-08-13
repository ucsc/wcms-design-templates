<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output indent="yes" method="xml"/> 
    <xsl:include href="/formats/Format Date"/>

    <xsl:template match="/system-index-block">
        <xsl:apply-templates select="calling-page/system-page"/>
    </xsl:template>
    
    <xsl:template match="system-page">
          
      <!-- Add page title -->
      <xsl:if test="title != ''">
        <h1 id="title">
          <xsl:apply-templates select="title"/>
        </h1>      
      </xsl:if>

    </xsl:template>
    
</xsl:stylesheet>