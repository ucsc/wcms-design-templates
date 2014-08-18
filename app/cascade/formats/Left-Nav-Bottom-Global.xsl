<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output indent="yes" method="xml" omit-xml-declaration="yes"/>
    <xsl:include href="/formats/Format Date"/>
    
    
    <xsl:template match="system-data-structure">
      <!-- If block header has content, print it -->
      <xsl:if test="block-content/header != ''">
        <h4 class="block-header">
            <xsl:value-of select="block-content/header"/>
        </h4>  
      </xsl:if>

      <!-- Test to see if there are items in the block -->
      <xsl:if test="block-content/item[1]/text != '' or block-content/item[1]/url != '' or block-content/item[1]/content != '' or block-content/item[1]/page/path != '' or block-content/item[1]/file/path != '' or block-content/item[1]/thumbnail/path != '' or block-content/item[1]/large-thumb/path != ''">
        <!-- Unordered list with additional left side content -->
        <ul class="block global">
            <xsl:apply-templates select="block-content/item"/>
        </ul>
      </xsl:if>
    </xsl:template>
    
    
    <xsl:template match="item">
      <li>
            <xsl:if test="thumbnail/path != '/' or large-thumb/path !='/'">
                <xsl:attribute name="class">imgLink</xsl:attribute>
            </xsl:if>
            <xsl:choose>
                <xsl:when test="url != '' or page/path != '/' or file/path != '/'">
                    <a>
                        <xsl:attribute name="href">
                            <xsl:choose>
                                <xsl:when test="url !=''">
                                    <xsl:value-of select="url"/>
                                </xsl:when>
                                <xsl:when test="page/path !='/'">
                                    <xsl:value-of select="page/link"/>
                                </xsl:when>
                                <xsl:when test="file/path !='/'">
                                    <xsl:value-of select="file/link"/>
                                </xsl:when>
                            </xsl:choose>
                        </xsl:attribute>
                        <xsl:apply-templates mode="thumbnail-check" select="."/>
                    </a>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates mode="thumbnail-check" select="."/>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:if test="thumbnail/path != '/' or large-thumb/path !='/'">
                <br class="clear-both"/>
            </xsl:if>
      </li>      
    </xsl:template>
    
    <xsl:template match="item" mode="thumbnail-check">
        <xsl:choose>
            <xsl:when test="thumbnail/path != '/'">
                <span class="floatLeftImg">
                    <img alt="{thumb-alt}" src="{thumbnail/link}" width="76"/>
                </span>
                <span class="floatLeftText">
                    <xsl:value-of select="text"/>
                </span>
            </xsl:when>
            <xsl:when test="large-thumb/path != '/'">
                <span class="floatLeftImg">
                    <img alt="{thumb-alt}" src="{large-thumb/link}" width="180"/>
                </span>
                <br/>
                <xsl:value-of select="text"/>
            </xsl:when>
            <xsl:when test="text !=''">
                <xsl:value-of select="text"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:copy-of select="content/node()"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>