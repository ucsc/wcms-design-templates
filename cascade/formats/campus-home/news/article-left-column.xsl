<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output indent="yes" method="xml"/> 

<!-- 

## Partials folder format for Server-Side Includes

This format takes a folder of HTML partials and outputs the left-article-column partial for internal use. We use the system-view tags to show the content of the include within Cascade and print an Apache SSI directive after the page is published. 

That allows us to include a system asset while the content editor is editing/viewing the content in the system, and use a published HTML file after the page is published.

 -->
      
    <xsl:template match="system-page">
        
        <xsl:if test="name = 'article-left-column'">
        
          [system-view:internal]
            <xsl:copy-of select="system-data-structure/content"/>
          [/system-view:internal]

          [system-view:external]
          <xsl:comment>#include virtual="/_partials/article-left-column.html" </xsl:comment>  
          [/system-view:external]

        </xsl:if>
          
    </xsl:template>
    
</xsl:stylesheet>