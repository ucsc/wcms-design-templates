<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output indent="yes" method="xml"/> 

<xsl:template match="/system-index-block">

    <xsl:for-each select="calling-page/system-page/system-data-structure/sidebar/sidebar-blocks">
      
    
        <div class="inner">
          <xsl:if test="title != ''">
            <h4><xsl:value-of select="title"/></h4>            
          </xsl:if>
          <xsl:copy-of select="content/node()"/>
        </div>
  
    </xsl:for-each>
    
</xsl:template> 
</xsl:stylesheet>