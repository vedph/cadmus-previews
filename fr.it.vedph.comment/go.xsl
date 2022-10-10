<?xml version="1.0" encoding="UTF-8"?>
<!-- Cadmus preview - fr.it.veph.comment -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="1.0">
    <xsl:output method="html"/>

    <!-- remove empty elements -->
    <xsl:template match="*[not(*) and not(normalize-space())]"> </xsl:template>

    <!-- build link -->
    <xsl:template name="build-link">
        <xsl:param name="val"/>
        <xsl:choose>
            <xsl:when test="starts-with($val, 'http')">
                <xsl:element name="a">
                    <xsl:attribute name="href">
                        <xsl:value-of select="$val"/>
                    </xsl:attribute>
                    <xsl:attribute name="target">_blank</xsl:attribute>
                    <xsl:value-of select="$val"/>
                </xsl:element>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$val"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- reference -->
    <xsl:template match="reference">
        <li>
            <xsl:if test="type">
                <span class="comment-ref-y">
                    <xsl:value-of select="type"/>
                </span>
            </xsl:if>
            <xsl:if test="tag">
                <span class="comment-ref-t">
                    <xsl:value-of select="tag"/>
                </span>
            </xsl:if>
            <xsl:if test="citation">
                <span class="comment-ref-c">
                    <xsl:call-template name="build-link">
                        <xsl:with-param name="val" select="citation"> </xsl:with-param>
                    </xsl:call-template>
                </span>
            </xsl:if>
            <xsl:if test="note">
                <xsl:text> </xsl:text>
                <span class="comment-ref-n">
                    <xsl:value-of select="note"/>
                </span>
            </xsl:if>
        </li>
    </xsl:template>

    <!-- root -->
    <xsl:template match="root">
        <html>
            <head>
                <style type="text/css">
                    .pv-flex-row {
                        display: flex;
                        gap: 8px;
                        align-items: center;
                        flex-wrap: wrap;
                    }
                    .pv-flex-row * {
                        flex: 0 0 auto;
                    }
                    .comment a {
                        text-decoration: none;
                    }
                    .comment a:hover {
                        text-decoration: underline;
                    }
                    .comment-tag {
                        color: silver;
                        font-weight: bold;
                        padding: 6px;
                        border: 1px solid silver;
                        border-radius: 6px;
                    }
                    .comment-text {
                        margin: 8px;
                        column-count: 4;
                        column-width: 400px;
                    }
                    .comment-category {
                        background-color: #afd3ff;
                        border: 1px solid #afd3ff;
                        border-radius: 6px;
                        padding: 6px;
                    }
                    .comment-keywords {
                        line-height: 200%;
                    }
                    .comment-kw-x {
                        background-color: #34eb98;
                        color: white;
                        border-radius: 4px;
                        padding: 4px;
                        margin: 0 4px;
                    }
                    .comment-kw-l {
                        background-color: #f5f3e1;
                        color: white;
                        border-radius: 4px;
                        padding: 4px;
                        margin: 0 4px;
                    }
                    .comment-kw-v {
                        color: #827609;
                    }
                    .comment-hdr {
                        color: royalblue;
                        border-bottom: 1px solid royalblue;
                        margin: 8px 0;
                        font-variant: small-caps;
                    }
                    .comment-references {
                        line-height: 200%;
                    }
                    .comment-ref-y {
                        background-color: #35c6ea;
                        color: white;
                        border-radius: 4px;
                        padding: 4px;
                        margin: 0 4px;
                    }
                    .comment-ref-t {
                        background-color: #34eb98;
                        color: white;
                        border-radius: 4px;
                        padding: 4px;
                        margin: 0 4px;
                    }
                    .comment-ref-c {
                    }
                    .comment-ref-n {
                        font-style: italic;
                    }
                    .comment-ids {
                        line-height: 200%;
                    }
                    .comment-id-t {
                        background-color: #34eb98;
                        color: white;
                        border-radius: 4px;
                        padding: 4px;
                        margin: 0 4px;
                    }
                    .comment-id-r {
                        font-weight: bold;
                        color: orange;
                    }
                    .comment-id-n {
                        font-style: italic;
                    }
                    .comment-id-s {
                        border: 1px solid orange;
                        border-radius: 4px;
                        padding: 4px;
                        margin: 0 4px;
                    }
                    .comment-assertion {
                        border: 1px solid orange;
                        border-radius: 6px;
                        padding: 6px;
                        margin: 4px;
                        background-color: #fefefe;
                    }
                    .comment-assertion-refs {
                    }</style>
            </head>
            <body>
                <div class="comment">
                    <!-- tag -->
                    <xsl:if test="tag">
                        <div class="comment-tag">
                            <xsl:value-of select="tag"/>
                        </div>
                    </xsl:if>

                    <!-- categories -->
                    <xsl:if test="categories">
                        <div class="pv-flex-row">
                            <xsl:for-each select="category">
                                <div class="comment-category">
                                    <xsl:value-of select="."/>
                                </div>
                            </xsl:for-each>
                        </div>
                    </xsl:if>

                    <!-- text -->
                    <xsl:if test="text">
                        <div class="comment-text">
                            <_md>
                                <xsl:value-of select="text"/>
                            </_md>
                        </div>
                    </xsl:if>

                    <!-- keywords -->
                    <xsl:if test="keywords">
                        <ul class="comment-keywords">
                            <xsl:for-each select="keyword">
                                <xsl:sort select="indexId"/>
                                <xsl:sort select="language"/>
                                <xsl:sort select="value"/>
                                <li>
                                    <span class="comment-kw-x">
                                        <xsl:value-of select="indexId"/>
                                    </span>
                                    <span class="comment-kw-l">^^<xsl:value-of select="language"
                                        /></span>
                                    <span class="comment-kw-v">
                                        <xsl:value-of select="value"/>
                                    </span>
                                </li>
                            </xsl:for-each>
                        </ul>
                    </xsl:if>

                    <!-- references -->
                    <xsl:if test="references">
                        <div class="comment-hdr">references</div>
                        <ol class="comment-references">
                            <xsl:apply-templates select="references/reference"/>
                        </ol>
                    </xsl:if>

                    <!-- externalIds -->
                    <xsl:if test="externalIds">
                        <div class="comment-hdr">identifiers</div>
                        <ul class="comment-ids">
                            <xsl:for-each select="externalIds/externalId">
                                <li>
                                    <xsl:if test="tag[normalize-space(.)]">
                                        <span class="comment-id-t">
                                            <xsl:value-of select="tag"/>
                                        </span>
                                    </xsl:if>
                                    <xsl:if test="scope[normalize-space(.)]">
                                        <span class="comment-id-s">
                                            <xsl:value-of select="scope"/>
                                        </span>
                                    </xsl:if>
                                    <span class="comment-id-v">
                                        <xsl:call-template name="build-link">
                                            <xsl:with-param name="val" select="value"/>
                                        </xsl:call-template>
                                    </span>
                                    <xsl:if test="assertion/*">
                                        <div class="comment-assertion">
                                            <xsl:if test="assertion/tag">
                                                <span class="comment-id-t">
                                                  <xsl:value-of select="assertion/tag"/>
                                                </span>
                                            </xsl:if>
                                            <xsl:if test="assertion/rank">
                                                <xsl:text> </xsl:text>
                                                <span class="comment-id-r">R<xsl:value-of
                                                  select="assertion/rank"/>
                                                </span>
                                            </xsl:if>
                                            <xsl:if test="assertion/note">
                                                <xsl:text> </xsl:text>
                                                <div class="comment-id-n">
                                                  <xsl:value-of select="assertion/note"/>
                                                </div>
                                            </xsl:if>
                                            <xsl:if test="assertion/references">
                                                <ol class="comment-assertion-refs">
                                                  <xsl:apply-templates
                                                  select="assertion/references/reference"/>
                                                </ol>
                                            </xsl:if>
                                        </div>
                                    </xsl:if>
                                </li>
                            </xsl:for-each>
                        </ul>
                    </xsl:if>
                </div>
            </body>
        </html>
    </xsl:template>

    <!-- fallback -->
    <xsl:template match="*"/>
</xsl:stylesheet>
