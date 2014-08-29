<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes" method="xml" omit-xml-declaration="yes"/>
<xsl:include href="/formats/Format Date"/>

<xsl:template match="system-data-structure/text-block">
  
    <h4 class="block-header"><xsl:value-of select="title1"/>&#160;<span><xsl:value-of select="title2"/></span></h4>
    <xsl:copy-of select="text/node()"/>
    
 
</xsl:template>
</xsl:stylesheet>