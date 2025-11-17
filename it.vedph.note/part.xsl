<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="tei" version="1.0">
    <xsl:output media-type="text/html" method="html" omit-xml-declaration="yes" encoding="UTF-8"/>
    <xsl:template match="tag[normalize-space(.)]">
        <div class="pv-muted">
            <xsl:value-of select="."/>
        </div>
    </xsl:template>
    <xsl:template match="text">
        <div class="pv-note-text">
            <_md>
                <xsl:value-of select="."/>
            </_md>
        </div>
    </xsl:template>
    <xsl:template match="root">
        <html lang="en">
            <head>
                <meta charset="UTF-8"/>
                <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
                <title>Note</title>
                <style type="text/css">
                    .pv-muted {
                        color: silver;
                    }
                    .note-text {
                        margin: 8px;
                        column-count: 4;
                        column-width: 400px;
                    }</style>
            </head>
            <body>
                <xsl:apply-templates/>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="*"/>
</xsl:stylesheet>
