<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl"
>
    <xsl:output method="xml" indent="yes"/>

  <xsl:template name="get-cloudiness">
    <xsl:param name="cloudiness"/>
    <xsl:choose>
      <xsl:when test="$cloudiness = 0"> ясно</xsl:when>
      <xsl:when test="$cloudiness = 1">  малооблачно</xsl:when>
      <xsl:when test="$cloudiness = 2"> облачно</xsl:when>
      <xsl:when test="$cloudiness = 3"> пасмурно</xsl:when>
      <xsl:otherwise>?</xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="get-precipitation">
    <xsl:param name="precipitation"/>
    <xsl:choose>
      <xsl:when test="$precipitation = 4">дождь </xsl:when>
      <xsl:when test="$precipitation = 5">ливень </xsl:when>
      <xsl:when test="$precipitation = 6">снег </xsl:when>
      <xsl:when test="$precipitation = 7">снег </xsl:when>
      <xsl:when test="$precipitation = 8">гроза </xsl:when>
      <xsl:when test="$precipitation = 9">нет данных </xsl:when>
      <xsl:when test="$precipitation = 10">без осадков </xsl:when>
      <xsl:otherwise>?</xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template match="//TOWN">
        <h1>Тюмень</h1>
        <xsl:apply-templates select="FORECAST"></xsl:apply-templates>
  </xsl:template>

  <xsl:template match="FORECAST">
    <article>
      <p><xsl:value-of select="@day"/>.<xsl:value-of select="@month"/>.<xsl:value-of select="@year"/>, <xsl:value-of select="@hour"/>:00</p>
      <div>
        <p>
            <xsl:apply-templates select="TEMPERATURE"></xsl:apply-templates>
            <xsl:apply-templates select="PHENOMENA"></xsl:apply-templates>
            <xsl:apply-templates select="WIND"></xsl:apply-templates>
        </p>
      </div>
    </article>
  </xsl:template>

  <xsl:template match="TEMPERATURE">
    <xsl:value-of select="@min"/>..<xsl:value-of select="@max"/>
  </xsl:template>

  <xsl:template match="PHENOMENA">
    <xsl:call-template name="get-cloudiness">
      <xsl:with-param name="cloudiness" select="@cloudiness" />
    </xsl:call-template>,
    <xsl:call-template name="get-precipitation">
      <xsl:with-param name="precipitation" select="@precipitation" />
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="WIND">
    <xsl:value-of select="@min"/>..<xsl:value-of select="@max"/> м/с
  </xsl:template>
  
</xsl:stylesheet>