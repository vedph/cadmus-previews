<?xml version="1.0" encoding="UTF-8"?>
<!-- Cadmus preview - fr.it.veph.chronology -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="1.0">
    <xsl:output media-type="text/html" method="html" omit-xml-declaration="yes" encoding="UTF-8"/>
    <!-- remove WS-only text nodes -->
    <xsl:strip-space elements="*"/>

    <!-- root -->
    <xsl:template match="root">
        <html lang="en">
            <head>
                <meta charset="UTF-8"/>
                <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
                <title>Chronology Fragment</title>
                <style type="text/css">
                </style>
            </head>
            <body>
                <div class="pv-chronology">
                    <span class="pv-fr-text">@{<xsl:value-of select="location"/>}</span>
                    <xsl:if test="label">
                        <xsl:text> </xsl:text>
                        <span class="pv-fr-label"><xsl:value-of select="label"/></span>
                    </xsl:if>
                    TODO
                </div>
            </body>
        </html>
    </xsl:template>

</xsl:stylesheet>