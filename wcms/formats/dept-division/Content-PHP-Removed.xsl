<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output indent="yes" method="xml"/> 
    <xsl:include href="/formats/content-pages/related-links"/>
    <xsl:template match="/system-index-block">
        <xsl:apply-templates select="calling-page/system-page"/>
    </xsl:template>
    
    <xsl:template match="system-page">
    
    <xsl:if test="title">
        <h1 id="title">
            <xsl:value-of select="title"/>
        </h1>
    </xsl:if>
        
        <xsl:if test="system-data-structure/banner/image/path != '/'">
            <div id="bannerBox">
            
                <!-- alt tag condition -->   
                <xsl:choose>
                    <xsl:when test="system-data-structure/banner/image-alt != ''">
                        <img alt="{system-data-structure/banner/image-alt}" id="banner" src="{system-data-structure/banner/image/path}"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <img alt="No Image Alternative Tag Provided" id="banner" src="{system-data-structure/banner/image/path}"/>
                    </xsl:otherwise>
                </xsl:choose>
            
                <xsl:if test="system-data-structure/banner/caption!= ''">
                <p class="caption">
                    <xsl:value-of select="system-data-structure/banner/caption"/>
                </p>
                </xsl:if>
            </div>
        </xsl:if>
        <xsl:for-each select="system-data-structure/content">
            <xsl:if test=". != ''">
                <div class="contentBox">
                    <xsl:apply-templates mode="no-php" select="@*|node()"/>
                </div>
            </xsl:if>
        </xsl:for-each>

            <xsl:if test="system-data-structure/links/page/path != '/' or system-data-structure/links/symlink/path != '/' or system-data-structure/url != 'http://'">
                <h3>See <span>Also</span></h3>
            <div id="seeAlso">
                <ul>
                        <xsl:apply-templates select="system-data-structure/related-links"/>
                    </ul>
                </div>
            </xsl:if>

    </xsl:template>

    <xsl:template match="@*|*" mode="no-php">
        <xsl:copy>
            <xsl:apply-templates mode="no-php" select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="processing-instruction() | comment()" mode="no-php"/>
        
</xsl:stylesheet>