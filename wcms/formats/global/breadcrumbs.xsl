<?xml version="1.0" encoding="UTF-8"?>
<!-- 

Breadcrumbs: the entire `div.row` is contained within this document, meaning we only have the region in the template. This removes the default <div> from appearing the template markup **unless* breadcrumbs are assigned to the region. 

 -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <!--
      Name of page to consider default page
      in a folder (i.e. index, default)
   -->
  <xsl:param name="defaultPage">index</xsl:param>

  <!--
      id attribute of top-level ul (blank for none)
   -->
  <xsl:param name="wrapperID">breadcrumbs</xsl:param>

  <!-- Do not modify below this point -->
  <xsl:template match="/system-index-block">
    <div class="row breadcrumbs">
      <p>
      <a>
        <xsl:attribute name="href">
          <xsl:value-of select="concat(path,'/',$defaultPage)"/>
        </xsl:attribute>
        Home</a> / <xsl:apply-templates select="descendant::system-folder[descendant::system-page[@current and not(@reference)] and not(ancestor::system-data-structure)] | descendant::system-page[@current and not(@reference) and not(name = $defaultPage) and not(ancestor::system-data-structure)]"/>
      </p>
    </div>
  </xsl:template>

  <xsl:template match="system-folder">

    <xsl:choose>
      <xsl:when test="system-page[@current and not(@reference)]/name = $defaultPage">
        <xsl:call-template name="get-asset-name"/>
      </xsl:when>
      <xsl:when test="system-page[not(@reference)]/name = $defaultPage">
        <a>
          <xsl:attribute name="href">
            <xsl:value-of select="concat(path,'/',$defaultPage)"/>
          </xsl:attribute>
          <xsl:call-template name="get-asset-name"/>
        </a>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="get-asset-name"/>
      </xsl:otherwise>
    </xsl:choose> <xsl:if test="position() != last()"> / </xsl:if>
  </xsl:template>

  <xsl:template match="system-page">
    <xsl:call-template name="get-asset-name"/>
  </xsl:template>

  <xsl:template name="get-asset-name">
    <xsl:choose>
      <xsl:when test="display-name">
        <xsl:value-of select="display-name"/>
      </xsl:when>
      <xsl:when test="title">
        <xsl:value-of select="title"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="name"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>