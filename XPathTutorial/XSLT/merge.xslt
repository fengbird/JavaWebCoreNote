<xsl:stylesheet 
 xmlns:xsl='http://www.w3.org/1999/XSL/Transform' version="1.0">


<xsl:output omit-xml-declaration="yes"/>

<xsl:param name="i"/>
<xsl:param name="trans">/tmp/source.xml</xsl:param>

<xsl:template match="/">
  <xsl:message>
    i: <xsl:value-of select="$i"/>
  </xsl:message>
  <xsl:apply-templates/>
</xsl:template>


<xsl:template match="*">
  <xsl:element name="{name()}">
    <xsl:copy-of select="@*"/>
    <xsl:apply-templates/>
  </xsl:element>
</xsl:template>


<xsl:template match="XPathTutorial">
  <xsl:element name="{name()}">
    <xsl:copy-of select="@*"/>
    <xsl:apply-templates select="key | description"/>
    <description lang="rus">
      <xsl:copy-of select="document($trans)//page[@id = $i]/description/node()"/>
    </description>
    <xsl:apply-templates select="source | example"/>
  </xsl:element>
</xsl:template>

<xsl:template match="example">
  <xsl:element name="{name()}">
    <xsl:copy-of select="@*"/>
    <xsl:apply-templates/>
    <p lang="rus">
      <xsl:copy-of select="document($trans)//page[@id = $i]/example[@path = current()/@path]/node()"/>
    </p>
    <xsl:apply-templates select="source | example"/>
  </xsl:element>
</xsl:template>





</xsl:stylesheet>