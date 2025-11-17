    <xsl:template name="render-date">
        <xsl:param name="date"/>

        <xsl:variable name="a" select="$date/a"/>
        <xsl:variable name="b" select="$date/b"/>

        <xsl:choose>
            <!-- Point: only a exists -->
            <xsl:when test="$a and not($b)">
                <xsl:call-template name="render-datation">
                    <xsl:with-param name="d" select="$a"/>
                </xsl:call-template>
            </xsl:when>

            <!-- Interval: both a and b exist -->
            <xsl:when test="$a and $b">
                <xsl:call-template name="render-datation">
                    <xsl:with-param name="d" select="$a"/>
                </xsl:call-template>
                <xsl:text> -- </xsl:text>
                <xsl:call-template name="render-datation">
                    <xsl:with-param name="d" select="$b"/>
                </xsl:call-template>
            </xsl:when>

            <!-- Terminus ante: only b exists -->
            <xsl:when test="not($a) and $b">
                <xsl:text>-</xsl:text>
                <xsl:call-template name="render-datation">
                    <xsl:with-param name="d" select="$b"/>
                </xsl:call-template>
            </xsl:when>

            <!-- Terminus post: only a exists -->
            <xsl:when test="$a and not($b)">
                <xsl:call-template name="render-datation">
                    <xsl:with-param name="d" select="$a"/>
                </xsl:call-template>
                <xsl:text>-</xsl:text>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="render-datation">
        <xsl:param name="d"/>

        <xsl:variable name="value" select="number($d/value)"/>
        <xsl:variable name="month" select="$d/month"/>
        <xsl:variable name="day" select="$d/day"/>
        <xsl:variable name="isCentury" select="$d/isCentury = 'true'"/>
        <xsl:variable name="isSpan" select="$d/isSpan = 'true'"/>
        <xsl:variable name="isApproximate" select="$d/isApproximate = 'true'"/>
        <xsl:variable name="isDubious" select="$d/isDubious = 'true'"/>
        <xsl:variable name="hint" select="$d/hint"/>
        <xsl:variable name="slide" select="number($d/slide)"/>

        <!-- Check if BC (negative value) -->
        <xsl:variable name="isBC" select="$value &lt; 0"/>
        <xsl:variable name="absValue">
            <xsl:choose>
                <xsl:when test="$isBC">
                    <xsl:value-of select="$value * -1"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$value"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <!-- Approximate indicator (c.) -->
        <xsl:if test="$isApproximate">
            <xsl:text>c. </xsl:text>
        </xsl:if>

        <!-- Day -->
        <xsl:if test="$day">
            <xsl:value-of select="$day"/>
            <xsl:text> </xsl:text>
        </xsl:if>

        <!-- Month -->
        <xsl:if test="$month">
            <xsl:choose>
                <xsl:when test="$month = 1">jan</xsl:when>
                <xsl:when test="$month = 2">feb</xsl:when>
                <xsl:when test="$month = 3">mar</xsl:when>
                <xsl:when test="$month = 4">apr</xsl:when>
                <xsl:when test="$month = 5">may</xsl:when>
                <xsl:when test="$month = 6">jun</xsl:when>
                <xsl:when test="$month = 7">jul</xsl:when>
                <xsl:when test="$month = 8">aug</xsl:when>
                <xsl:when test="$month = 9">sep</xsl:when>
                <xsl:when test="$month = 10">oct</xsl:when>
                <xsl:when test="$month = 11">nov</xsl:when>
                <xsl:when test="$month = 12">dec</xsl:when>
            </xsl:choose>
            <xsl:text> </xsl:text>
        </xsl:if>

        <!-- Value (year or century) -->
        <xsl:choose>
            <!-- Century: convert to Roman numerals -->
            <xsl:when test="$isCentury">
                <xsl:call-template name="to-roman">
                    <xsl:with-param name="num" select="$absValue"/>
                </xsl:call-template>
                <!-- Slide for century -->
                <xsl:if test="$slide and $slide != 0">
                    <xsl:text>:</xsl:text>
                    <xsl:variable name="endCentury">
                        <xsl:choose>
                            <xsl:when test="$isBC">
                                <xsl:value-of select="$absValue - $slide"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="$absValue + $slide"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:variable>
                    <xsl:call-template name="to-roman">
                        <xsl:with-param name="num" select="$endCentury"/>
                    </xsl:call-template>
                </xsl:if>
            </xsl:when>
            <!-- Regular year -->
            <xsl:otherwise>
                <xsl:value-of select="$absValue"/>
                <!-- Span -->
                <xsl:if test="$isSpan">
                    <xsl:text>/</xsl:text>
                    <xsl:choose>
                        <xsl:when test="$isBC">
                            <xsl:value-of select="$absValue - 1"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="$absValue + 1"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:if>
                <!-- Slide for year -->
                <xsl:if test="$slide and $slide != 0">
                    <xsl:text>:</xsl:text>
                    <xsl:choose>
                        <xsl:when test="$isBC">
                            <xsl:value-of select="$absValue - $slide"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="$absValue + $slide"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:if>
            </xsl:otherwise>
        </xsl:choose>

        <!-- Era (BC/AD) -->
        <xsl:text> </xsl:text>
        <xsl:choose>
            <xsl:when test="$isBC">BC</xsl:when>
            <xsl:otherwise>AD</xsl:otherwise>
        </xsl:choose>

        <!-- Dubious indicator (?) -->
        <xsl:if test="$isDubious">
            <xsl:text>?</xsl:text>
        </xsl:if>

        <!-- Hint -->
        <xsl:if test="$hint">
            <xsl:text> {</xsl:text>
            <xsl:value-of select="$hint"/>
            <xsl:text>}</xsl:text>
        </xsl:if>
    </xsl:template>

    <xsl:template name="to-roman">
        <xsl:param name="num"/>
        <xsl:choose>
            <xsl:when test="$num &gt;= 1000">
                <xsl:text>M</xsl:text>
                <xsl:call-template name="to-roman">
                    <xsl:with-param name="num" select="$num - 1000"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:when test="$num &gt;= 900">
                <xsl:text>CM</xsl:text>
                <xsl:call-template name="to-roman">
                    <xsl:with-param name="num" select="$num - 900"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:when test="$num &gt;= 500">
                <xsl:text>D</xsl:text>
                <xsl:call-template name="to-roman">
                    <xsl:with-param name="num" select="$num - 500"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:when test="$num &gt;= 400">
                <xsl:text>CD</xsl:text>
                <xsl:call-template name="to-roman">
                    <xsl:with-param name="num" select="$num - 400"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:when test="$num &gt;= 100">
                <xsl:text>C</xsl:text>
                <xsl:call-template name="to-roman">
                    <xsl:with-param name="num" select="$num - 100"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:when test="$num &gt;= 90">
                <xsl:text>XC</xsl:text>
                <xsl:call-template name="to-roman">
                    <xsl:with-param name="num" select="$num - 90"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:when test="$num &gt;= 50">
                <xsl:text>L</xsl:text>
                <xsl:call-template name="to-roman">
                    <xsl:with-param name="num" select="$num - 50"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:when test="$num &gt;= 40">
                <xsl:text>XL</xsl:text>
                <xsl:call-template name="to-roman">
                    <xsl:with-param name="num" select="$num - 40"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:when test="$num &gt;= 10">
                <xsl:text>X</xsl:text>
                <xsl:call-template name="to-roman">
                    <xsl:with-param name="num" select="$num - 10"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:when test="$num &gt;= 9">
                <xsl:text>IX</xsl:text>
                <xsl:call-template name="to-roman">
                    <xsl:with-param name="num" select="$num - 9"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:when test="$num &gt;= 5">
                <xsl:text>V</xsl:text>
                <xsl:call-template name="to-roman">
                    <xsl:with-param name="num" select="$num - 5"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:when test="$num &gt;= 4">
                <xsl:text>IV</xsl:text>
                <xsl:call-template name="to-roman">
                    <xsl:with-param name="num" select="$num - 4"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:when test="$num &gt;= 1">
                <xsl:text>I</xsl:text>
                <xsl:call-template name="to-roman">
                    <xsl:with-param name="num" select="$num - 1"/>
                </xsl:call-template>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
