<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
    <xsl:import href="single-legal-document.xsl"/>

    <xsl:template match="/" name="main">
  
        <xsl:for-each select="doc('../xml/EULA_OXYGEN.xml')">
            <xsl:call-template name="generate">
                <xsl:with-param name="profile.product" select="'EDITOR'"/>
                <xsl:with-param name="profile.range" select="'USER'"/>
            <xsl:with-param name="output.file.prefix" select="'EULA_OxygenXML_'"/>
            </xsl:call-template>
            <xsl:call-template name="generate">
                <xsl:with-param name="profile.product" select="'AUTHOR'"/>
                <xsl:with-param name="profile.range" select="'USER'"/>
            <xsl:with-param name="output.file.prefix" select="'EULA_OxygenXML_'"/>
            </xsl:call-template>

            <xsl:call-template name="generate">
                <xsl:with-param name="profile.product" select="'DEVELOPER'"/>
                <xsl:with-param name="profile.range" select="'USER'"/>
            <xsl:with-param name="output.file.prefix" select="'EULA_OxygenXML_'"/>
            </xsl:call-template>

            <xsl:call-template name="generate">
                <xsl:with-param name="profile.product" select="'DIFF'"/>
                <xsl:with-param name="profile.range" select="'USER'"/>
            <xsl:with-param name="output.file.prefix" select="'EULA_OxygenXML_'"/>
            </xsl:call-template>

            <xsl:call-template name="generate">
                <xsl:with-param name="profile.product" select="'EDITOR'"/>
                <xsl:with-param name="profile.edition" select="'ACADEMIC'"/>
                <xsl:with-param name="profile.range" select="'CLASS'"/>
            <xsl:with-param name="output.file.prefix" select="'EULA_OxygenXML_'"/>
            </xsl:call-template>
            <xsl:call-template name="generate">
                <xsl:with-param name="profile.product" select="'EDITOR'"/>
                <xsl:with-param name="profile.edition" select="'ACADEMIC'"/>
                <xsl:with-param name="profile.range" select="'DEPARTMENTAL'"/>
            <xsl:with-param name="output.file.prefix" select="'EULA_OxygenXML_'"/>
            </xsl:call-template>
            <xsl:call-template name="generate">
                <xsl:with-param name="profile.product" select="'EDITOR'"/>
                <xsl:with-param name="profile.edition" select="'ACADEMIC'"/>
                <xsl:with-param name="profile.range" select="'SITE'"/>
            <xsl:with-param name="output.file.prefix" select="'EULA_OxygenXML_'"/>
            </xsl:call-template>
        </xsl:for-each>
        <xsl:for-each select="doc('../xml/EULA_OXYGEN_SDK.xml')">
            <xsl:call-template name="generate">
                <xsl:with-param name="output.file" 
                    select="concat(string-join(tokenize(document-uri(/), '/')[position() &lt; last()], '/'), 
                    '/../txt/generated/EULA_OxygenXML_SDK.txt')"/>
            </xsl:call-template>            
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>
