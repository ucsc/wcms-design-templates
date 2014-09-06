<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    
    <xsl:template match="/system-index-block">
        <!-- Start by outputting an HTML unordered list that wraps around the whole navigation menu -->
        <ul>
            <xsl:apply-templates mode="top-level" select="(descendant::system-folder[descendant-or-self::system-folder[@current] and count(descendant-or-self::system-folder[descendant-or-self::system-folder[@current]]) &lt;= 3])[1]"/>
        </ul>
    </xsl:template>
    
    <xsl:template match="system-folder" mode="top-level">
        <xsl:apply-templates select="system-page[name = 'index' and not(@reference)]"/>
        <xsl:apply-templates select="system-page[name != 'index' or @reference] | system-folder | system-symlink"/>
    </xsl:template>
    
    <!--
        Each of the following templates outputs an HTML list item element for every
        folder, page, and external link selected by the above XPath.
    -->
    <xsl:template match="system-folder">
        <li>
            <!--
                Generate a link to the 'index' page within the folder.
                Use the folder's (not the index page's) display name as the text.
            -->
            <a href="site://{site}{path}/index">
                <xsl:if test="system-page[name = 'index' and @current and not(@reference)]">
                    <xsl:attribute name="class">current</xsl:attribute>
                </xsl:if>
                <xsl:call-template name="get-asset-name"/>
            </a>
            <!-- 
                Check whether this folder or any descendants of this folder are the current folder.
                If so, list the contents of this folder recursively until we get to the current folder.
                Like:
                /
                \_folder
                \_folder
                \_folder
                | \_page
                | \_page
                | \_currentFolder
                | | \_page
                | | \_currentPage*
                | \_folder
                \_folder
            -->
            <!--
                Removed [system-page[name = 'index']] from system-folder to allow linking to folders
                inside of which we can't see the 'index' page. This could, however, cause us to link
                to folders that _don't have_ index pages, leading to 404 errors.
            -->
            <xsl:if test="descendant-or-self::system-folder[@current] and (system-page[name != 'index' or @reference] | system-folder | system-symlink)">
                <ul>
                    <xsl:apply-templates select="system-page[name != 'index' or @reference] | system-folder | system-symlink"/>
                </ul>
            </xsl:if>
        </li>
    </xsl:template>
    
    
    <xsl:template match="system-page">
        <xsl:choose>
            <xsl:when test="dynamic-metadata/value = 'Exclude'">                
                <li class="excluded" style="display:none;">
                    <span style="display:none;">Excluded</span>
                    <xsl:comment>item excluded from display by user.</xsl:comment>
                </li>
            </xsl:when>
            <xsl:otherwise>
            <li>
                <a href="{link}">
                    <xsl:call-template name="get-asset-name"/>
                </a>
            </li>
          </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- allows for include/exclude page from left navigation (via default metadata), 
    includes hack that adds empty <li/> element for when all pages in directory are set to be excluded; 
    without this subsequent directories appear at wrong level. -->
    <xsl:template match="system-page[@current]">
        <xsl:choose>
            <xsl:when test="dynamic-metadata/value = 'Exclude'">
                 
                <li class="excluded" style="display:none;">
                    <span style="display:none;">Excluded</span>
                    <xsl:comment>item excluded from display by user.</xsl:comment>
                </li>

            </xsl:when>
            <xsl:otherwise>
                <li>
                    <a class="current" href="{link}">
                        <xsl:call-template name="get-asset-name"/>
                    </a>
                </li>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="system-symlink">
        <li>            
            <a class="external" href="{link}">
                <xsl:call-template name="get-asset-name"/>
            </a>
        </li>
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