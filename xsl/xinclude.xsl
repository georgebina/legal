<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xi="http://www.w3.org/2001/XInclude"
    version="2.0">
    
    <xsl:template match="node() | @*" mode="xi">
        <xsl:copy>
            <xsl:apply-templates select="node() | @*" mode="xi"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="xi:include" mode="xi">
        <xsl:variable name="xpointer" select="@xpointer"/>
        <xsl:choose>
            <xsl:when test="$xpointer">
                <xsl:apply-templates select="document(@href, .)//*[@xml:id = $xpointer]" mode="xi"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates select="document(@href, .)" mode="xi"/>                
            </xsl:otherwise>
        </xsl:choose>        
        
    </xsl:template>
    
    <xsl:template match="/">
        <xsl:apply-templates select="*" mode="xi"/>
    </xsl:template>
</xsl:stylesheet>