<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes" method="xml" omit-xml-declaration="yes"/>
<xsl:include href="/formats/Format Date"/>

<!--
Pattern for future block types:
[begin example]

<xsl:template match="*[content/system-data-structure/IDENTIFIER_IN_SD_BLOCK]" mode="news-block">
... content to render from block ...
LIKE: <xsl:value-of select="content/system-data-structure/IDENTIFIER_IN_SD_BLOCK/..." />
</xsl:template>

[end example]
-->

<xsl:template match="*[content/system-data-structure/more-link]" mode="news-block">
    <div class="content-box">
    <xsl:if test="content/system-data-structure/title != ''">
        <h3><xsl:value-of select="content/system-data-structure/title"/></h3>
    </xsl:if>
        <ul class="archive-list">
            <xsl:variable name="regionLimit" select="number(content/system-data-structure/number)"/>
            <xsl:comment>
            Total NEWS Pages: <xsl:value-of select="count(ancestor::system-data-structure/news-index/content/system-index-block//system-page)"/>
            Categories in region: <xsl:value-of select="dynamic-metadata[starts-with(name,'category-')]/value"/>
            News Pages with those categories: <xsl:value-of select="count(ancestor::system-data-structure/news-index/content/system-index-block//system-page[dynamic-metadata[starts-with(name,'category-')]/value = current()/dynamic-metadata[starts-with(name,'category-')]/value])"/>
            </xsl:comment>
            <xsl:for-each select="ancestor::system-data-structure/news-index/content/system-index-block//system-page[not(@current) and not(system-data-structure/page-type = 'Category Index') and dynamic-metadata[starts-with(name,'category-')]/value = current()/dynamic-metadata[starts-with(name,'category-')]/value]">
                <xsl:sort data-type="number" order="descending" select="start-date"/>
                <xsl:if test="position() &lt;= $regionLimit">
                    <li>
                    <xsl:choose>        
                    <xsl:when test="system-data-structure/lead-image/image-thumb/path != '/'">
                    <a href="{link}" title="Read more about {title}">
                     <img alt="{system-data-structure/lead-image/image-thumb-alt}" class="right" src="{system-data-structure/lead-image/image-thumb/link}"/> 
                    </a>
                    <span class="date">
                    <xsl:call-template name="format-date">
                    <xsl:with-param name="date" select="start-date"/> 
                    <xsl:with-param name="mask">mmm dd, yyyy</xsl:with-param> 
                    </xsl:call-template>
                    </span> 
                    <h2><a href="{link}">
                        <xsl:value-of select="title"/>
                    </a></h2>
                    <p>
                      <xsl:apply-templates select="summary"/>
                    </p>
                    </xsl:when>
                    <xsl:otherwise> 
                    <h3>
                      <a href="{link}"><xsl:value-of select="title"/></a>
                    </h3>
                    <p><xsl:value-of select="summary"/></p> 
                    </xsl:otherwise>
                    </xsl:choose>
                    
                    </li>
                    </xsl:if>           
            </xsl:for-each>
        </ul>
        <xsl:for-each select="content/system-data-structure/more-link[content]">
            <p class="more"><a class="more-link" href="{link}">More stories</a></p>
        </xsl:for-each>
    </div>
</xsl:template>

<xsl:template match="*[content[not(system-data-structure) and count(node()) &gt; 0]]" mode="news-block">
    <xsl:copy-of select="content/node()"/>
</xsl:template>

<!-- Catch any system-data-structure blocks that are not defined above -->
<xsl:template match="*[content/system-data-structure]" mode="news-block" priority="-10">
    [system-view:internal]<h3>INVALID BLOCK TYPE</h3><div class="inner">Invalid Block Type</div>[/system-view:internal]
    [system-view:external]<h3><xsl:value-of select="ancestor::calling-page/system-page/display-name"/></h3><div class="inner"><xsl:value-of select="ancestor::calling-page/system-page/summary"/></div>[/system-view:external]
</xsl:template>

<!-- Suppress anything else getting selected but not matched -->
<xsl:template match="*" mode="news-block" priority="-15"/>

</xsl:stylesheet>