<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes" method="xml"/> 
      
<xsl:template match="system-data-structure">
<xsl:for-each select="features" xml:space="preserve">        
<xsl:comment><xsl:value-of select="path"/></xsl:comment>
<xsl:copy-of select="content/node()"/>
</xsl:for-each>      
</xsl:template>
    
</xsl:stylesheet>