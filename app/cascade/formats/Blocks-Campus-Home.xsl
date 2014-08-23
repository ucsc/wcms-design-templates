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
    <xsl:template match="*[content/system-data-structure/profile]" mode="homepage-block">
        <div id="profile" class="profile-block">
            <h3>Uncommon <span>People</span></h3>
            <div class="inner">
                <!-- Is there a thumbnail assigned in the SD block? -->
                <xsl:if test="content/system-data-structure/profile/content/system-data-structure/profile-content/thumb/link != '/'">
                    <a href="{content/system-data-structure/profile/link}" title="Read more about {content/system-data-structure/profile/content/system-data-structure/profile-content/title}">
                        <img alt="Uncommon People: {content/system-data-structure/profile/content/system-data-structure/profile-content/title}" src="{content/system-data-structure/profile/content/system-data-structure/profile-content/thumb/link}"/>
                    </a>    
                </xsl:if>
                <a class="upTitle" href="{content/system-data-structure/profile/link}" title="Read more about {content/system-data-structure/profile/content/system-data-structure/profile-content/title}">
                    <xsl:value-of select="content/system-data-structure/profile/content/system-data-structure/profile-content/title"/>
                </a>
                <p>
                    <xsl:value-of select="content/system-data-structure/profile/content/system-data-structure/profile-content/description"/>
                    <a class="continu" href="{content/system-data-structure/profile/link}" title="Read more about {content/system-data-structure/profile/content/system-data-structure/profile-content/title}"> Continue&#187;</a>
                </p>
            </div>
        </div>
    </xsl:template>
    <xsl:template match="*[content/system-data-structure/video_url]" mode="homepage-block">
        <div id="video" class="video-block">
            <h3>Video <span>Spotlight</span>
            </h3>
            <div class="inner">
                <xsl:if test="content/system-data-structure/video_thumb/link != '/'">
                    <xsl:if test="content/system-data-structure/video_url">
                        <a class="fb thumb_link" href="{content/system-data-structure/video_url}" title="Watch this video about {content/system-data-structure/video_title}">
                            <img alt="Play this video" class="play_btn" height="35" src="site://static/images/play_btn.png" width="48"/>
                            <img alt="YouTube video thumbnail" src="{content/system-data-structure/video_thumb/link}" width="216"/>
                        </a>
                    </xsl:if>
                </xsl:if>
                <xsl:if test="content/system-data-structure/video_thumb/link = '/'">
                    <img alt="YouTube video thumbnail" src="{content/system-data-structure/video_thumb/link}" width="216"/>
                </xsl:if>
                <xsl:if test="content/system-data-structure/video_title">
                    <a class="fb upTitle" href="{content/system-data-structure/video_url}" title="Watch this video about {content/system-data-structure/video_title}">
                        <xsl:value-of select="content/system-data-structure/video_title"/>
                    </a>
                </xsl:if>
                <xsl:if test="content/system-data-structure/video_description">
                    <p>
                        <xsl:copy-of select="content/system-data-structure/video_description/node()"/>
                        <xsl:if test="content/system-data-structure/video_url">&#160;<a class="fb continu" href="{content/system-data-structure/video_url}" title="Watch this video about {content/system-data-structure/video_title}">Watch&#187;</a> | <a class="fb continu" href="site://news/video/index" title="Video Library">Video Library&#187;</a>
                        </xsl:if>
                    </p>
                </xsl:if>
            </div>
        </div>
    </xsl:template>
    
    
<xsl:template match="*[content/system-data-structure/video-embed]" mode="homepage-block">
  <xsl:variable name="button" select="content/system-data-structure/video-embed/play-btn"/>
    <div id="video" class="video-block">
        <h3>Video <span>Spotlight</span>
        </h3>
        <div class="inner">

      <!-- If there is a URL for the video, link to it. -->
            <xsl:if test="content/system-data-structure/video-embed/video-url != ''">
                <xsl:if test="content/system-data-structure/video-embed/video-url">
                    <a class="fb thumb_link" href="{content/system-data-structure/video-embed/video-url}" title="Watch this video about {content/system-data-structure/video-embed/title}">
                        <img alt="Play this video" class="play_btn" height="35" src="site://static/images/play_btn.png" width="48"/>
                        <img alt="Video thumbnail" src="{content/system-data-structure/video-embed/thumbnail/link}" width="216"/>
                    </a>
                </xsl:if>
            </xsl:if>

      <!-- If there is a title for the video, link it to the video URL -->
            <xsl:if test="content/system-data-structure/video-embed/title">
                <a class="fb upTitle" href="{content/system-data-structure/video-embed/video-url}" title="Watch this video about {content/system-data-structure/video-embed/title}">
                    <xsl:value-of select="content/system-data-structure/video-embed/title"/>
                </a>
            </xsl:if>
            
      <!-- If there is a description for the video, place it here and link to the video at the end. -->
            <xsl:if test="content/system-data-structure/video-embed/description">
                <p>
                    <xsl:copy-of select="content/system-data-structure/video-embed/description/node()"/>
                    <xsl:if test="content/system-data-structure/video-embed/video-url">&#160;<a class="fb continu" href="{content/system-data-structure/video-embed/video-url}" title="Watch this video about {content/system-data-structure/video-embed/title}">Watch&#187;</a>
                    </xsl:if>
                </p>
            </xsl:if>
            
      <!-- Wrap the embed code in a <div> that we will hide and then reveal with fancybox. -->
            <xsl:if test="content/system-data-structure/video-embed/embed-code">
            <div id="hidden">
             <div id="video-wrap">
                    <xsl:value-of select="content/system-data-structure/video-embed/embed-code"/>
             </div>
            </div>           
            </xsl:if>
            
        </div>
    </div>
</xsl:template> 
    
    
    
    
    
    
    
    
    <xsl:template match="*[content/system-data-structure/slide]" mode="homepage-block">
        <div id="view" class="gallery-view">
            <h3>The <span>View</span>
            </h3>
            <div class="inner">
                <xsl:for-each select="content/system-data-structure/slide[image[link!='/']]">
                    <a href="{image/link}" rel="lightbox" title="(View the full-size version) {alt}">
                        <img alt="{alt}" src="{thumb/link}"/>
                    </a>
                </xsl:for-each>
            </div>
        </div>
    </xsl:template>
    <xsl:template match="*[content[not(system-data-structure) and count(node()) &gt; 0]]" mode="homepage-block">
        <xsl:copy-of select="content/node()"/>
    </xsl:template>
    <!-- Catch any system-data-structure blocks that are not defined above -->
    <xsl:template match="*[content/system-data-structure]" mode="homepage-block" priority="-10">
        [system-view:internal]<h3>INVALID BLOCK TYPE</h3>
        <div class="inner">Invalid Block Type</div>
        [/system-view:internal]
        [system-view:external]<h3>
            <xsl:value-of select="ancestor::calling-page/system-page/display-name"/>
        </h3>
        <div class="inner">
            <xsl:value-of select="ancestor::calling-page/system-page/summary"/>
        </div>
        [/system-view:external]
    </xsl:template>
</xsl:stylesheet>