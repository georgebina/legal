<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  xmlns:legal="http://www.oxygenxml.com/legal-document"
  version="2.0">
  
  <xsl:template match="node() | @*" mode="ref">
    <xsl:copy>
      <xsl:apply-templates select="node() | @*" mode="ref"/>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="legal:ref" mode="ref">
    <xsl:variable name="refId" select="@refId"/>
    <xsl:variable name="element" select="//*[@xml:id=$refId]"/>
    <xsl:call-template name="reference">
      <xsl:with-param name="element" select="$element"/>
    </xsl:call-template>
    <xsl:if test="$element/legal:title">
      <xsl:text> (</xsl:text>
      <xsl:value-of select="$element/legal:title"/>
      <xsl:text>)</xsl:text>
    </xsl:if>
  </xsl:template>

  <xsl:template name="reference">
    <xsl:param name="element"/>
    <xsl:choose>
      <xsl:when test="$element[self::legal:section]">
        <xsl:number select="$element"/>
      </xsl:when>
      <xsl:when test="$element[self::legal:item]">
        <xsl:call-template name="reference">
          <xsl:with-param name="element" select="$element/.."/>
        </xsl:call-template>
        <xsl:text>.</xsl:text>
        <xsl:number select="$element" format="{if ($element/../@numeration='alpha') then 'alpha' else '1'}"/>
      </xsl:when>
      <xsl:when test="$element[parent::*]">
        <xsl:call-template name="reference">
          <xsl:with-param name="element" select="$element/.."/>
        </xsl:call-template>
      </xsl:when>
    </xsl:choose>
    
  </xsl:template>

</xsl:stylesheet>
