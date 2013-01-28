<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:legal="http://www.oxygenxml.com/legal-document" version="2.0">
    <!-- Stylesheet processing a single legal document -->

    <xsl:import href="xinclude.xsl"/>
    <xsl:import href="profile.xsl"/>
    <xsl:import href="ref.xsl"/>
    <xsl:import href="formatText.xsl"/>

    <xsl:function name="legal:capitalize">
        <xsl:param name="string"/>
        <xsl:value-of select="concat(
             upper-case(substring($string, 1, 1)),
             lower-case(substring($string, 2)))"/>
    </xsl:function>
    
    <xsl:template name="generate">
        <xsl:param name="profile.product" select="''"/>
        <xsl:param name="profile.edition" select="''"/>
        <xsl:param name="profile.range" select="''"/>
        <xsl:param name="output.file.prefix" select="''"/>
        <xsl:param name="output.file">              
            <!-- The name of the output file, derived from the parameters -->
            <xsl:value-of select="concat(string-join(tokenize(document-uri(/), '/')[position() &lt; last()], '/'), '/../txt/generated/')"/>
            <xsl:value-of select="$output.file.prefix"/>
            <xsl:value-of select="legal:capitalize($profile.product)"/>
            <xsl:if test="$profile.edition">
                <xsl:text>_</xsl:text>
                <xsl:value-of select="legal:capitalize($profile.edition)"/>
            </xsl:if>
            <xsl:if test="$profile.range and $profile.range != 'USER'">                
                <xsl:text>_</xsl:text>
                <xsl:value-of select="legal:capitalize($profile.range)"/>
            </xsl:if>
            <xsl:text>.txt</xsl:text>
        </xsl:param>
        
        <xsl:message>Generating: <xsl:value-of select="$output.file"/> </xsl:message>
        <xsl:result-document href="{$output.file}">
            <!-- XInclude processing -->
            <xsl:variable name="xincluded">
                <xsl:apply-templates select="/*" mode="xi"/>
            </xsl:variable>
            
            <!-- Profiling -->
            <xsl:variable name="profiled">
                <xsl:apply-templates select="$xincluded" mode="profile">
                    <xsl:with-param name="profile.product" select="$profile.product"/>
                    <xsl:with-param name="profile.edition" select="$profile.edition"/>
                    <xsl:with-param name="profile.range" select="$profile.range"/>
                </xsl:apply-templates>
            </xsl:variable>
            
            <!-- References -->
            <xsl:variable name="resolved">
                <xsl:apply-templates select="$profiled" mode="ref"/>
            </xsl:variable>
            
            <!-- Styling -->
            <xsl:apply-templates select="$resolved/*" mode="format"/>            
        </xsl:result-document>        
    </xsl:template>
</xsl:stylesheet>
