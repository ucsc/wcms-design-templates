<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output indent="yes" method="xml" omit-xml-declaration="yes"/>
    <xsl:include href="/formats/Format Date"/>
    
    <xsl:variable name="nav-block" select="system-index-block/calling-page/system-page/system-data-structure/left-bottom-nav"/>
  
    <xsl:template match="system-index-block">
      <!-- If block header has content, print it -->
      <xsl:if test="$nav-block/content/system-data-structure/block-content/header != ''">
        <h4>
          <xsl:value-of select="$nav-block/content/system-data-structure/block-content/header"/>
        </h4>
      </xsl:if>
      
      <!-- Test to see if there are items in the block -->
      <xsl:if test="$nav-block/content/system-data-structure/block-content/item[1]/text != '' or $nav-block/content/system-data-structure/block-content/item[1]/url != '' or $nav-block/content/system-data-structure/block-content/item[1]/content != '' or $nav-block/content/system-data-structure/block-content/item[1]/page/path != '/' or $nav-block/content/system-data-structure/block-content/item[1]/file/path != '/' or $nav-block/content/system-data-structure/block-content/item[1]/thumbnail/path != '/' or $nav-block/content/system-data-structure/block-content/item[1]/large-thumb/path != '/'">
        <!-- Unordered list with additional left side content -->
        <ul class="block page">
          <xsl:apply-templates select="$nav-block/content/system-data-structure/block-content/item"/>
        </ul>        
      </xsl:if>
    </xsl:template>
    
    
    <xsl:template match="item">
      <li>
            <xsl:if test="thumbnail/path != '/' or large-thumb/path !='/'">
                <xsl:attribute name="class">image-item</xsl:attribute>
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
        </li>    
    </xsl:template>
    
    <xsl:template match="item" mode="thumbnail-check">
        <xsl:choose>
            <!-- When there is a small thumbnail -->
            <xsl:when test="thumbnail/path != '/'">
                <span class="thumbnail">
                    <img alt="{thumb-alt}" src="{thumbnail/link}" />
                </span>
                <span class="description">
                    <xsl:value-of select="text"/>
                </span>
            </xsl:when>
            <!-- When there is a wide thumbnail -->
            <xsl:when test="large-thumb/path != '/'">
                <span class="thumbnail">
                    <img alt="{thumb-alt}" src="{large-thumb/link}" class="landscape" />
                </span>
                <span class="description">
                    <xsl:value-of select="text"/>
                </span>
            </xsl:when>
            <!-- When there is text -->
            <xsl:when test="text !=''">
                <span class="description">
                    <xsl:value-of select="text"/>
                </span>
            </xsl:when>
            <xsl:otherwise>
              <xsl:copy-of select="content/node()"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>