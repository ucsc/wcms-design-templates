<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output indent="yes" method="xml"/> 
  <xsl:include href="/formats/Format Date"/>
  <xsl:include href="/formats/content-pages/related-links"/>
  
  <xsl:template match="/system-index-block">
    <xsl:apply-templates select="calling-page/system-page"/>
  </xsl:template>
  
  <xsl:template match="system-page">
    <h1 id="title">
      <xsl:value-of select="title"/>
    </h1>
    
    <xsl:if test="system-data-structure/article-subhead != ''">
      <p id="subhead"><xsl:value-of select="system-data-structure/article-subhead"/></p>
    </xsl:if>
    
    
    <xsl:if test="system-data-structure/admin/audience !=''">
      <h3>To: <xsl:value-of select="system-data-structure/admin/audience"/></h3>
    </xsl:if>
    
    <xsl:if test="system-data-structure/admin/admin !=''">
      <h3>From: <xsl:value-of select="system-data-structure/admin/admin"/></h3>
    </xsl:if>
    
    <p class="date">
      <xsl:call-template name="format-date">
        <xsl:with-param name="date" select="start-date"/>
        <xsl:with-param name="mask">mmmm dd, yyyy</xsl:with-param>
      </xsl:call-template>
    </p>
    
    <!-- Add vcard only if contact is filled in. -->
    <xsl:if test="system-data-structure/contact != ''">
      <p class="vcard"><xsl:apply-templates select="system-data-structure/contact"/></p>
    </xsl:if>
    
    <div class="content-box">
    
    <!-- Add main image -->
    <xsl:if test="system-data-structure/lead-image/image/path != '/' or system-data-structure/lead-image/image-caption != ''">
      <xsl:apply-templates select="system-data-structure/lead-image"/>      
    </xsl:if>

    <!-- Add secondary images -->
    <xsl:if test="system-data-structure/secondary-images/image/path != '/'">
      <xsl:apply-templates select="system-data-structure/secondary-images"/>
    </xsl:if>
    
    <!-- Add article text -->
    <xsl:for-each select="system-data-structure/article-text">
      <xsl:if test=". != ''">
        <div class="article-body"><xsl:copy-of select="node()"/></div>
      </xsl:if>
    </xsl:for-each>
    
    </div>
    
  <!-- Add related links -->
    <!-- REMOVED...IS NOW CONTENT BOTTOM REGION FORMAT
  <xsl:if test="system-data-structure/related-links/page/path != '/' or system-data-structure/related-links/symlink/path != '/' or system-data-structure/related-links/url != 'http://'">      
    <div class="seeAlso">
    <h3>See <span>Also</span></h3>
    <ul>
          <xsl:apply-templates select="system-data-structure/related-links"/>
        </ul>
      </div>
    </xsl:if>
  -->
    
</xsl:template>
  
  <xsl:template match="contact">
  
  <xsl:choose>
    <xsl:when test="name != '' and email !=''">
      By   
      <a class="email fn" href="mailto:{email}"><xsl:value-of select="name"/></a>
      <xsl:if test="title != ''">, </xsl:if>
    </xsl:when>
    
    <xsl:when test="name != ''">
      By   
      <xsl:value-of select="name"/>
      <xsl:if test="title != ''">, </xsl:if>
    </xsl:when>

  </xsl:choose>  
    <xsl:if test="name = '' and title != ''">
    By
    </xsl:if>
    
    <xsl:if test="title != ''">
    <span class="role"><xsl:value-of select="title"/></span>  
    </xsl:if>  
    <xsl:text>&#160;</xsl:text>
    <span class="tel"><xsl:value-of select="phone"/></span>
    <xsl:if test="position() != last()"><br/></xsl:if>
  </xsl:template>

  <xsl:template match="lead-image | secondary-images">

<!--
    Removed 09/06/2014 due to complexity for user. -RK
    <xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'"/>
    <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'"/>
    <xsl:variable name="layout-style" select="layout-width"/>
    <xsl:variable name="layout" select="translate($layout-style, $uppercase, $smallcase)"/>
 -->    
    <figure>
      <xsl:attribute name="class">article-image</xsl:attribute>
      <xsl:if test="image/path !='/'">    
          <xsl:if test="contains('empty.png',image/name)">
              <!-- Empty to print caption --><br/>
          </xsl:if>
          <xsl:if test="not(contains('empty.png',image/name))">
              <img alt="{image/display-name}" src="{image/path}"/>
          </xsl:if>       
      </xsl:if>
        
      <xsl:if test="image-caption != ''">
        <figcaption class="caption">
          <xsl:copy-of select="image-caption/node()"/>
        </figcaption>
      </xsl:if>
              
    </figure>
  </xsl:template>
  
</xsl:stylesheet>