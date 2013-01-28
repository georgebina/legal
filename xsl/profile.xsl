<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">

    <xsl:template match="text()" mode="profile">
        <xsl:copy/>
    </xsl:template>
    <xsl:template match="@*" mode="profile">
        <xsl:copy-of select="."/>
    </xsl:template>

    <xsl:template match="*" mode="profile">
        <!-- The name of the product that will enter output -->
        <!-- EDITOR, DEVELOPER, etc.. -->
        <xsl:param name="profile.product"/>
        <!-- The name of the edition that will enter output -->
        <!-- ACADEMIC, ENTERPRISE, etc.. -->
        <xsl:param name="profile.edition"/>
        <!-- The license range will enter output -->
        <!-- DEPARTMENTAL, SITE, etc.. -->
        <xsl:param name="profile.range"/>

        <xsl:variable name="product" select="@product"/>
        <xsl:variable name="edition" select="@edition"/>
        <xsl:variable name="range" select="@range"/>

        <xsl:if
            test="(string-length($product)=0 or 
                      contains($product, $profile.product)) and 
                      (string-length($edition)=0 or 
                      contains($edition, $profile.edition)) and
                      (string-length($range)=0 or 
                      contains($range, $profile.range))">
            <xsl:copy>
                <xsl:apply-templates select="@*" mode="profile"/>
                <xsl:apply-templates mode="profile">
                    <xsl:with-param name="profile.product" select="$profile.product"/>
                    <xsl:with-param name="profile.edition" select="$profile.edition"/>
                    <xsl:with-param name="profile.range" select="$profile.range"/>
                </xsl:apply-templates>
            </xsl:copy>
        </xsl:if>
    </xsl:template>

</xsl:stylesheet>
