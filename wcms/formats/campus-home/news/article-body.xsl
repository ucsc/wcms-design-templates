<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output indent="yes" method="xml"/>
    <xsl:include href="/formats/Format Date"/>
    <xsl:include href="/formats/content-pages/related-links"/>

    <xsl:variable name="siteURL"><xsl:text>http://news.ucsc.edu</xsl:text></xsl:variable>
    <xsl:variable name="page-url"><xsl:value-of select="$siteURL"/><xsl:value-of select="/system-index-block/calling-page/system-page/path"/>.html</xsl:variable>

    <xsl:template match="/system-index-block">
        <xsl:apply-templates select="calling-page/system-page"/>
    </xsl:template>

    <xsl:template match="system-page">
        <!-- Print the title, if it exists. -->
        <xsl:if test="title">
          <h1 id="title">
              <xsl:value-of select="title"/>
          </h1>
        </xsl:if>

        <!-- Print the subhead, if there is one. -->
        <xsl:if test="system-data-structure/article-subhead != ''">
            <p class="subhead"><xsl:value-of select="system-data-structure/article-subhead"/></p>
        </xsl:if>

        <!-- If this is a campus message -->
        <xsl:if test="system-data-structure/admin/audience !='' or system-data-structure/admin/admin !=''">
            <div class="campus-message">
                <!-- Who is it TO? -->
                <xsl:if test="system-data-structure/admin/audience !=''">
                    <p><strong>To:</strong> <xsl:text>&#160;</xsl:text><xsl:value-of select="system-data-structure/admin/audience"/></p>
                </xsl:if>
                <!-- If this is a campus message, who is it FROM? -->
                <xsl:if test="system-data-structure/admin/admin !=''">
                    <p><strong>From:</strong> <xsl:text>&#160;</xsl:text><xsl:value-of select="system-data-structure/admin/admin"/></p>
                </xsl:if>
            </div>
        </xsl:if>

        <div class="article-meta">

        <div class="article-info">
        <!-- Print the article date -->
        <p class="date">
            <xsl:call-template name="format-date">
                <xsl:with-param name="date" select="start-date"/>
                <xsl:with-param name="mask">mmmm dd, yyyy</xsl:with-param>
            </xsl:call-template>

            <!-- Show "last updated" date (if checked on the article) -->
            <xsl:if test="system-data-structure/show-updated/value = 'Yes'">
            <span class="last-updated"> (updated:
              <xsl:call-template name="format-date">
                  <xsl:with-param name="date" select="last-modified-on"/>
                  <xsl:with-param name="mask">mm/dd/yy, h:MMtt</xsl:with-param>
              </xsl:call-template>
            )</span>
            </xsl:if>
        </p>

        <!-- Add vcard only if contact is filled in. -->
        <xsl:if test="system-data-structure/contact != ''">
            <p class="vcard"><xsl:apply-templates select="system-data-structure/contact"/></p>
        </xsl:if>
    </div>

  <div class="social-sharing">
<span>Share this story:</span>
<a class="icon icon-twitter--inverted" href="https://twitter.com/intent/tweet?text={title}&amp;url={$page-url}&amp;via=ucsc">Twitter</a>
<a class="icon icon-facebook--inverted" href="https://www.facebook.com/sharer/sharer.php?t={title}&amp;u={$page-url}">Facebook</a>
<a class="icon icon-google-plus--inverted" href="https://plus.google.com/share?url={$page-url}">Google+</a>
<a class="icon icon-linkedin--inverted" href="http://www.linkedin.com/shareArticle?mini=true&amp;title={title}&amp;url={$page-url}&amp;source=http%3a%2f%2fnews.ucsc.edu">LinkedIn</a>
<a class="icon icon-reddit--inverted" href="http://www.reddit.com/submit?url={$page-url}">Reddit</a>
</div>
        </div>

        <div class="contentBox">

        <!-- Add lead video -->
        <xsl:if test="system-data-structure/video/embed != ''">
          <xsl:apply-templates select="system-data-structure/video"/>
        </xsl:if>

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
                <div class="article-body">
                <xsl:copy-of select="node()"/></div>
            </xsl:if>
        </xsl:for-each>

        <!-- News articles can have comments, if a box is checked. See article form for details. -->
        <xsl:if test="system-data-structure/comments/value = 'Yes'">
        <div class="comments" style="margin-top:4em;border-top:1px solid #dddddd;padding-top:2em;">
                <div id="disqus_thread"></div>
                <script type="text/javascript">

                    var disqus_shortname = 'ucsc';
                    (function() {
                        var dsq = document.createElement('script'); dsq.type = 'text/javascript'; dsq.async = true;
                        dsq.src = 'http://' + disqus_shortname + '.disqus.com/embed.js';
                        (document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(dsq);
                    })();
                </script>
                <noscript><p style="margin:2em 0em;border-top:1px solid #dddddd;padding-top:2em;">Please enable JavaScript to view the <a href="http://disqus.com/?ref_noscript">Comments powered by Disqus.</a></p></noscript>
                <a class="dsq-brlink" href="http://disqus.com">Comments powered by <span class="logo-disqus">Disqus</span></a>
        </div>
        </xsl:if>

  <div class="social-sharing">
<span>Share this story:</span>
<a class="icon icon-twitter--inverted" href="https://twitter.com/intent/tweet?text={title}&amp;url={$page-url}&amp;via=ucsc">Twitter</a>
<a class="icon icon-facebook--inverted" href="https://www.facebook.com/sharer/sharer.php?t={title}&amp;u={$page-url}">Facebook</a>
<a class="icon icon-google-plus--inverted" href="https://plus.google.com/share?url={$page-url}">Google+</a>
<a class="icon icon-linkedin--inverted" href="http://www.linkedin.com/shareArticle?mini=true&amp;title={title}&amp;url={$page-url}&amp;source=http%3a%2f%2fnews.ucsc.edu">LinkedIn</a>
<a class="icon icon-reddit--inverted" href="http://www.reddit.com/submit?url={$page-url}">Reddit</a>
</div>


        </div><!-- End the .contentBox -->

</xsl:template>

<!-- Print contact name -->
<xsl:template match="contact">

    <!-- Name and email given, so we print them. -->
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

        <xsl:otherwise>
            <!-- No name or email given. -->
        </xsl:otherwise>
    </xsl:choose>

    <!-- No name, just title given -->
    <xsl:if test="name = '' and title != ''">
        By
    </xsl:if>

    <xsl:if test="title != ''">
        <span class="role"><xsl:value-of select="title"/></span>
    </xsl:if>

    <!-- Phone number given -->
    <xsl:if test="phone != ''">
        <xsl:text>&#160;</xsl:text>
        <span class="tel"><xsl:value-of select="phone"/></span>
    </xsl:if>

    <xsl:if test="position() != last()"><br/></xsl:if>

</xsl:template>

<xsl:template match="video">

  <figure class="article-video" style="width:{width}px;">
    <xsl:copy-of select="embed/node()"/>
    <xsl:if test="caption != ''">
        <figcaption class="caption">
            <xsl:copy-of select="caption/node()"/>
        </figcaption>
    </xsl:if>
  </figure>

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
