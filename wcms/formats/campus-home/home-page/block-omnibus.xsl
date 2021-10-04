<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output indent="yes" method="xml" omit-xml-declaration="yes"/>

<!--
  Pattern for future block types:
    
    [begin example]
 
      <xsl:template match="*[content/system-data-structure/IDENTIFIER_IN_SD_BLOCK]" mode="homepage-block">
         ... content to render from block ...
         LIKE: <xsl:value-of select="content/system-data-structure/IDENTIFIER_IN_SD_BLOCK/..." />
      </xsl:template>
 
    [end example]
-->


  <!-- $image-class: Images inside of blocks get a uniform class. Change it here to change it in all blocks. -->
  <xsl:variable name="image-class">block-image</xsl:variable>

  <!-- Profile block ("Uncommon People") -->
  <xsl:template match="*[content/system-data-structure/profile]" mode="homepage-block">
   <div class="block profile-block" id="profile">
     <h3 class="block-header">Uncommon <span>People</span></h3>
     <div class="inner">
       <!-- Is there a thumbnail assigned in the block? -->
       <xsl:if test="content/system-data-structure/profile/content/system-data-structure/profile-content/thumb/link != '/'">
         <a href="{content/system-data-structure/profile/link}">
           <img alt="{content/system-data-structure/profile/content/system-data-structure/profile-content/title}" class="{$image-class}" src="{content/system-data-structure/profile/content/system-data-structure/profile-content/thumb/link}"/>
         </a>    
       </xsl:if>
       <a class="upTitle" href="{content/system-data-structure/profile/link}">
         <xsl:value-of select="content/system-data-structure/profile/content/system-data-structure/profile-content/title"/>
       </a>
       <p>
         <xsl:value-of select="content/system-data-structure/profile/content/system-data-structure/profile-content/description"/>
         <a class="continu" href="{content/system-data-structure/profile/link}"> Continue&#187;</a>
       </p>
     </div>
   </div>
  </xsl:template>

  <!-- Video block -->
  <xsl:template match="*[content/system-data-structure/video_url]" mode="homepage-block">
    <div class="block video-block" id="video">
    <h3 class="block-header">Video <span>Spotlight</span></h3>
      <div class="inner">
        <!-- Is there a thumbnail assigned in the block? -->
        <xsl:if test="content/system-data-structure/video_thumb/link != '/'">
          <xsl:if test="content/system-data-structure/video_url">
            <a class="thumb_link" href="{content/system-data-structure/video_url}">
               <img alt="Play this video" class="play-button" height="35" src="site://static/images/play_btn.png" width="48"/>
               <img alt="YouTube video thumbnail" class="{$image-class}" src="{content/system-data-structure/video_thumb/link}" width="285"/>
             </a>
           </xsl:if>
         </xsl:if>
         <xsl:if test="content/system-data-structure/video_thumb/link = '/'">
           <img alt="YouTube video thumbnail" class="{$image-class}" src="{content/system-data-structure/video_thumb/link}" width="285"/>
         </xsl:if>
         <xsl:if test="content/system-data-structure/video_title">
           <a class="upTitle" href="{content/system-data-structure/video_url}">
             <xsl:value-of select="content/system-data-structure/video_title"/>
           </a>
         </xsl:if>
         <xsl:if test="content/system-data-structure/video_description">
           <p>
             <xsl:copy-of select="content/system-data-structure/video_description/node()"/>
             <xsl:if test="content/system-data-structure/video_url">&#160;<a class="continu" href="{content/system-data-structure/video_url}">Watch&#187;</a> | <a class="continu" href="site://news/video/index" title="Video Library">Video Library&#187;</a>
           </xsl:if>
         </p>
       </xsl:if>
     </div>
   </div>
  </xsl:template>

  <!-- Slideshow block (not currently used, -rk 2014) -->
  <xsl:template match="*[content/system-data-structure/slide]" mode="homepage-block">
    <div class="block gallery-block" id="view">
      <h3 class="block-header">The <span>View</span>
    </h3>
    <div class="inner">
      <xsl:for-each select="content/system-data-structure/slide[image[link!='/']]">
        <a href="{image/link}" rel="lightbox">
          <img alt="{alt}" src="{thumb/link}"/>
        </a>
      </xsl:for-each>
    </div>
  </div>
  </xsl:template>

  <!-- WYSIWYG, freeform block -->
  <xsl:template match="*[content[not(system-data-structure) and count(node()) &gt; 0]]" mode="homepage-block">
    <xsl:copy-of select="content/node()"/>
  </xsl:template>

  <!-- Catch any system-data-structure blocks that are not defined above -->
  <xsl:template match="*[content/system-data-structure]" mode="homepage-block" priority="-10">
    [system-view:internal]
    <h3>INVALID BLOCK TYPE</h3>
    <div class="inner">Invalid Block Type</div>
    [/system-view:internal]
    
    [system-view:external]
    <h3><xsl:value-of select="ancestor::calling-page/system-page/display-name"/></h3>
    <div class="inner">
      <xsl:value-of select="ancestor::calling-page/system-page/summary"/>
    </div>
    [/system-view:external]
  </xsl:template>

</xsl:stylesheet>