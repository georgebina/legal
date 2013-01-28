<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:legal="http://www.oxygenxml.com/legal-document" 
    version="2.0">
    
    <xsl:output method="text"/>
    
    <!-- Normalize all the text nodes. Note the fix for restoring the whitespaces. -->
    <xsl:template match="text()" mode="format">
        <xsl:if test="string-length(normalize-space()) > 0">            
            <xsl:if
                test="
                starts-with(., ' ') or
                starts-with(., '&#10;')">
                <xsl:text> </xsl:text>
            </xsl:if>
            <xsl:value-of select="normalize-space()"/>
            <xsl:if
                test="    
                ends-with(., ' ') or
                ends-with(., '&#10;')">
                <xsl:text> </xsl:text>
            </xsl:if>        
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="legal:title" mode="format">
        <xsl:value-of select="normalize-space()"/>
        <xsl:text>&#10;</xsl:text>
    </xsl:template>
    
    <xsl:template match="legal:list" mode="format">
        <xsl:text>&#10;</xsl:text>
        <xsl:apply-templates mode="format"/>
    </xsl:template>
    
    <!-- Number and indent the list items. -->
    <xsl:template match="legal:item" mode="format">
        <xsl:choose>
            <xsl:when test="string(../@numeration) = 'alpha'">
                <!-- Simple numeration, like a) , b) , c) -->
                <!-- Add an indent-->
                <xsl:for-each select="ancestor-or-self::legal:item">                    
                    <xsl:text>   </xsl:text>
                </xsl:for-each>
                <xsl:number format="a) "/>
            </xsl:when>
            <xsl:otherwise>
                <!-- Complex decimal numeration, including the section number and the parent items.-->
                <xsl:text> </xsl:text>
                <xsl:for-each select="ancestor::legal:section">
                    <xsl:value-of select="count(preceding-sibling::legal:section) + 1"/>
                    <xsl:text>.</xsl:text>
                </xsl:for-each>
                
                <!-- An interesting element, very powerful -->
                <xsl:number level="multiple" format="1. "/>
            </xsl:otherwise>
        </xsl:choose>
        
        <xsl:apply-templates mode="format"/>
        <xsl:if test="count(following-sibling::legal:item) != 0">            
            <xsl:text>&#10;</xsl:text>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="legal:important" mode="format">
        <xsl:text>&#10;</xsl:text>
        <xsl:text>IMPORTANT:</xsl:text>
        <xsl:apply-templates mode="format"/>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>&#10;</xsl:text>
    </xsl:template>
    
    <xsl:template match="legal:section" mode="format">
        <xsl:text>&#10;</xsl:text>
        <xsl:number format="1. "/>
        <xsl:apply-templates mode="format"/>
        <xsl:text>&#10;</xsl:text>
    </xsl:template>
    
    <xsl:template match="legal:addendum" mode="format">
        <xsl:text>&#10;</xsl:text>
        <xsl:apply-templates mode="format"/>
        <xsl:text>&#10;</xsl:text>
    </xsl:template>
    
    
</xsl:stylesheet>