<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xmlns:hh="http://www.hannonhill.com/XSL/Functions">

    <xsl:output indent="yes" method="xml"/> 
    <xsl:include href="/formats/Format Date"/>
    <xsl:variable name="current-date" select="/system-index-block/@current-time"/>
    
    <xsl:template match="/system-index-block">
    
        <!-- Test for a page title before outputting the <h1> -->
        <xsl:if test="calling-page/system-page/title">
            <h1 class="page-title" id="title">
              <xsl:value-of select="calling-page/system-page/title"/>
            </h1>
        </xsl:if>

        <div>
            <xsl:apply-templates select="calling-page/system-page/system-data-structure"/>
        </div>                
   
    </xsl:template>
    
    <xsl:template match="system-data-structure">
    
        <xsl:if test="banner/image/path != '/'">
            <div id="bannerBox" class="banner-box">
            
                <!-- alt tag condition -->
                <xsl:choose>
                    <xsl:when test="banner/image-alt !=''">
                        <img alt="{banner/image-alt}" id="banner" src="{banner/image/path}"/>
                    </xsl:when>
                    <xsl:otherwise>No alternative text</xsl:otherwise>
                </xsl:choose>

                <xsl:if test="banner/caption != ''">
                <p class="caption">
                    <xsl:value-of select="banner/caption"/>
                </p>
                
                </xsl:if>
            </div>
        </xsl:if>
            <div class="contentBox content-box">
                <xsl:copy-of select="intro/node()"/>

                <ul class="archive-list list-page">   
                    <xsl:apply-templates select="item"/>
                </ul>
            </div>

            <xsl:if test="bottom-text/node() !=''">
                <hr/>
                <div>
                    <xsl:copy-of select="bottom-text/node()"/>
                </div>
            </xsl:if>
        </xsl:template>
    
    <xsl:template match="item">
    
        <!-- define alt tag variable -->
        <xsl:variable name="alt-tag">
            <xsl:choose>
                <xsl:when test="alt !=''">
                    <xsl:value-of select="alt"/>
                </xsl:when>
                <xsl:otherwise>No alternative text</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        
        <xsl:if test="section-head != ''">
            <hr/>
            <h2><xsl:value-of select="section-head"/></h2>
        </xsl:if>
            <li>
                <xsl:choose>
            <!-- if its a URL -->
                <xsl:when test="url !=''">
                    <xsl:choose>
                        <xsl:when test="thumbnail/path != '/'">
                            <a href="{url}">
                                <img alt="{$alt-tag}" class="right" src="{thumbnail/link}" title="{alt}"/> 
                            </a>
                        <xsl:if test="title != ''">
                        <h4>
                            <a href="{url}">
                                <xsl:value-of select="title"/>
                            </a>
                        </h4>
                        </xsl:if>
                            <xsl:copy-of select="text/node()"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <h4>
                                <a href="{url}">
                                    <xsl:value-of select="title"/>
                                </a>
                            </h4>
                                <xsl:copy-of select="text/node()"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                
            <!-- if its a page -->  
                
                <xsl:when test="page/path !='/'">
                    <xsl:choose>
                        <xsl:when test="thumbnail/path != '/'">
                            <a href="{page/link}">
                                <img alt="{$alt-tag}" class="right" src="{thumbnail/link}" title="{alt}"/> 
                            </a>
                            <xsl:if test="title != ''">
                            <h4>
                                <a href="{page/link}">
                                    <xsl:value-of select="title"/>
                                </a>
                            </h4>
                            </xsl:if>
                            <xsl:copy-of select="text/node()"/>
                    
                        </xsl:when>
                        <xsl:otherwise>
                            <h4><a href="{page/link}">
                                <xsl:value-of select="title"/>
                            </a></h4>
                            <xsl:copy-of select="text/node()"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                
                <!-- If its a file -->
                <xsl:when test="file/path !='/'">
                    <xsl:choose>
                        <xsl:when test="thumbnail/path != '/'">
                            <a href="{file/link}">
                                <img alt="{$alt-tag}" class="right" src="{thumbnail/link}" title="{alt}"/> 
                            </a>
                            <xsl:if test="title != ''">
                            <h4>
                                <a href="{file/link}">
                                    <xsl:value-of select="title"/>
                                </a>
                            </h4>
                            </xsl:if>
                            <xsl:copy-of select="text/node()"/>
                        </xsl:when>
                        <xsl:otherwise>
                
                            <h4><a href="{file/link}">
                                <xsl:value-of select="title"/>
                            </a></h4>
                    
                            <xsl:copy-of select="text/node()"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                
                <!-- If there is no link specified -->
                
                <xsl:otherwise>
                    <xsl:choose>
                        <xsl:when test="thumbnail/path != '/'">
                            <img alt="{$alt-tag}" class="right" src="{thumbnail/link}" title="{alt}"/> 
                            <xsl:if test="title != ''">
                            <h4>
                            <xsl:value-of select="title"/>
                            </h4>
                            </xsl:if>
                            <xsl:copy-of select="text/node()"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:choose>
                                <xsl:when test="title/node() != '' ">
                                    <h4>
                                        <xsl:value-of select="title"/>
                                    </h4>
                                </xsl:when>
                            </xsl:choose>
                            <xsl:copy-of select="text/node()"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:otherwise>
            </xsl:choose>
        </li>
    </xsl:template>
</xsl:stylesheet>