<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes" method="xml" omit-xml-declaration="yes"/>

  <xsl:template match="/system-index-block">
    <div class="owl-carousel" id="slides">
      <xsl:if test="calling-page/system-page/system-data-structure/billboards-random/value = 'Yes'">
        <xsl:attribute name="class">random</xsl:attribute>
      </xsl:if>
      <xsl:apply-templates select="calling-page/system-page/system-data-structure/billboards"/>
    </div>
  </xsl:template>


  <!-- Template for each billboard -->
  <xsl:template match="billboards">

    <!-- If there is a link, we set this variable. -->
    <xsl:variable name="link-target">
      <xsl:choose>
        <xsl:when test="page/path != '/'">
          <xsl:value-of select="page/link"/>
        </xsl:when>
        <xsl:when test="symlink/path != '/'">
          <xsl:value-of select="symlink/path"/>
        </xsl:when>
        <xsl:when test="url !=''">
          <xsl:value-of select="url"/>        
        </xsl:when>
        <xsl:otherwise>no-link</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <!-- Begin building the slide. -->
    <div class="slide">

      <xsl:choose>
        <xsl:when test="$link-target !='no-link' and headline != '' and teaser != ''">          
          <a href="{$link-target}">        
          <!-- If there is a headline and teaser, we use the new style -->
          <xsl:if test="headline != '' and teaser != ''">
            <div>
              <xsl:attribute name="class">slide-body layout-<xsl:value-of select="layout"/> color-<xsl:value-of select="color"/></xsl:attribute>
              <!-- Print the slide headline. -->
              <div class="slide-title">
                <xsl:value-of select="headline"/>
              </div>
              <!-- Print the slide teaser. -->
              <p class="slide-teaser">          
                <xsl:value-of select="teaser"/>
                <!-- Print the link text with a preceding space. -->
                <xsl:if test="link-text != ''">
                  &#160;<span style="text-decoration:underline;"><xsl:value-of select="link-text"/></span>
                </xsl:if>
              </p>        
            </div>            
            <!-- Print the slide image. -->
            <img alt="{alt-text}" src="{image/path}" width="780"/>
          </xsl:if>
          </a>
        </xsl:when>
        <xsl:otherwise>
          <!-- If there is a headline and teaser, we use the new style -->
          <xsl:if test="headline != '' and teaser != ''">
            <div>
              <xsl:attribute name="class">slide-body layout-<xsl:value-of select="layout"/> color-<xsl:value-of select="color"/></xsl:attribute>
              <!-- Print the slide headline. -->
              <div class="slide-title">
                <xsl:value-of select="headline"/>
              </div>
              <!-- Print the slide teaser. -->
              <p class="slide-teaser">          
                <xsl:value-of select="teaser"/>                
              </p>        
            </div>
            <!-- Print the slide image. -->
            <img alt="{alt-text}" src="{image/path}" width="780"/>
          </xsl:if>
        </xsl:otherwise>
      </xsl:choose>
        
      
      <!--
        If the headline and teaser are absent, we use the old style. [DEPRECATE]
      -->
      <xsl:if test="headline = '' or teaser = ''">
        <xsl:choose>
          <xsl:when test="page/path != '/'">
            <a href="{page/link}"><img alt="{alt-text}" src="{image/path}" width="780"/></a>
          </xsl:when>
          <xsl:when test="symlink/path != '/'">
            <a href="{symlink/path}"><img alt="{alt-text}" src="{image/path}" width="780"/></a>
          </xsl:when>
          <xsl:when test="url != ''">  
            <a href="{url}"><img alt="{alt-text}" src="{image/path}" width="780"/></a>
          </xsl:when>        
          <xsl:otherwise>  
            <img alt="{alt-text}" src="{image/path}" width="780"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:if>
        
    </div> 

  </xsl:template>
  
</xsl:stylesheet>