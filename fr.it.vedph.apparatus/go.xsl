<?xml version="1.0" encoding="UTF-8"?>
<!-- Cadmus preview - fr.it.veph.apparatus -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="1.0">
    <xsl:output media-type="text/html" method="html" omit-xml-declaration="yes" encoding="UTF-8"/>
    
    <!-- remove empty elements -->
    <xsl:template match="*[not(*) and not(normalize-space())]">
    </xsl:template>
    
    <!-- lemma -->
    <xsl:template match="lemma">
        <span class="apparatus-lemma">
            <xsl:value-of select="."/>
        </span>        
    </xsl:template>
    
    <!-- witnesses (one per entry) -->
    <xsl:template match="witnesses">
        <span class="apparatus-w-value">
            <xsl:value-of select="value"/>
        </span>
        <xsl:if test="note">
            <span class="apparatus-w-note">
                <xsl:text> </xsl:text>
                <xsl:value-of select="note"/>
                <xsl:text> </xsl:text>
            </span>
        </xsl:if>
    </xsl:template>

    <!-- authors (one per entry) -->
    <xsl:template match="authors">
        <xsl:text> </xsl:text>
        <span class="apparatus-a-value">
            <xsl:value-of select="value"/>
        </span>
        <xsl:if test="note">
            <xsl:text> </xsl:text>
            <span class="apparatus-a-note">
                <xsl:value-of select="note"/>
            </span>
        </xsl:if>
        <xsl:text> </xsl:text>
    </xsl:template>

    <!-- entries (one per entry) -->
    <xsl:template match="entries">
        <xsl:variable name="nr">
            <xsl:number/>
        </xsl:variable>
        <xsl:if test="$nr &gt; 1">
            <span class="apparatus-sep">| </span>
        </xsl:if>
        <xsl:if test="tag">
            <span class="apparatus-tag">
                <xsl:value-of select="tag"/>
            </span>
            <xsl:text> </xsl:text>
        </xsl:if>
        <xsl:if test="subrange">
            <span class="apparatus-subrange">
                <xsl:value-of select="subrange"/>
            </span>
            <xsl:text> </xsl:text>
        </xsl:if>
        <xsl:if test="string-length(value) &gt; 0">
            <span class="apparatus-value">
                <xsl:value-of select="value"/>
            </span>
            <xsl:text> </xsl:text>
        </xsl:if>
        <xsl:choose>
            <xsl:when test="type = 0">
                <xsl:if test="string-length(value) = 0">
                    <span class="apparatus-type">del. </span>
                </xsl:if>
            </xsl:when>
            <xsl:when test="type = 1">
                <span class="apparatus-type">ante lemma </span>
            </xsl:when>
            <xsl:when test="type = 2">
                <span class="apparatus-type">post lemma </span>
            </xsl:when>
        </xsl:choose>
        <xsl:if test="note">
            <span class="apparatus-note">
                <xsl:value-of select="note"/>
            </span>
            <xsl:text> </xsl:text>
        </xsl:if>
        <xsl:apply-templates/>
    </xsl:template>
    
    <!-- root -->
    <xsl:template match="root">
        <html>
            <head>
                <style type="text/css">
                 .apparatus-lemma { padding: 2px 4px; border: 1px solid silver; border-radius: 4px; margin-right: 4px; color: #065e1d; }
                 .apparatus-w-value { font-weight:bold; }
                 .apparatus-w-note { font-style: italic;  }
                 .apparatus-a-value { font-style: italic;  }
                 .apparatus-a-note { font-style: italic;  }
                 .apparatus-sep { margin-left: 0.75em; }
                 .apparatus-tag { font-style: italic; }
                 .apparatus-subrange { color: silver; }
                 .apparatus-value { color: #b8690f; }
                 .apparatus-type { font-style: italic;  }
                 .apparatus-note { font-style: italic;  }
                </style>
            </head>
            <body>
                <xsl:apply-templates/>                
            </body>
        </html>
    </xsl:template>

    <!-- fallback -->
    <xsl:template match="*"/>
</xsl:stylesheet>
