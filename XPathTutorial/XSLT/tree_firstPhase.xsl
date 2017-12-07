<xsl:stylesheet xmlns:xsl='http://www.w3.org/1999/XSL/Transform' xmlns:saxon="http://icl.com/saxon" extension-element-prefixes="saxon" version="1.1"> 


<xsl:output method="xml" indent="yes"/>



<xsl:template match="xm_sources">
 <all>
	  <xsl:apply-templates select="//example" mode="description">
	    <xsl:sort select="string-length(@path)" data-type="number"/>
	  </xsl:apply-templates>
 </all>
</xsl:template> 


<xsl:template match="text()" mode="splitPath">
  <xsl:value-of select="concat(' | ','preceding-sibling::source',.)"/>
</xsl:template>

<xsl:template name="parsePath">
  <xsl:variable name="path">
    <xsl:apply-templates select="saxon:tokenize(@path,'|')" mode="splitPath"/>
  </xsl:variable>
  <xsl:apply-templates select="preceding-sibling::source/node()" mode="print">
    <xsl:with-param name="selectedNodes" select="saxon:evaluate(substring-after($path,'|'))"/>
    </xsl:apply-templates>
</xsl:template>


<xsl:template match="example" mode="description">

 <xsl:variable name="id">
  <xsl:value-of select="concat(parent::*/@id,'_',count(preceding-sibling::example))"/>
 </xsl:variable>

   <ex id="{$id}">
    <path><xsl:value-of select="@path"/></path>
    <source>
     <xsl:call-template name="parsePath"/>
    </source>
   </ex>
</xsl:template>


<xsl:template match="*" mode="print">
  <xsl:param name="selectedNodes"/>

  <xsl:element name="{name()}">

    <xsl:choose>
      <xsl:when test="count($selectedNodes | .)  = count($selectedNodes)">
       <xsl:attribute name="jj_el">
        <xsl:value-of select="'on'"/>
       </xsl:attribute>
      </xsl:when>
      <xsl:otherwise/>
    </xsl:choose>

   <xsl:apply-templates select="@*" mode="print">
     <xsl:with-param name="selectedNodes" select="$selectedNodes"/>
   </xsl:apply-templates>

   <xsl:apply-templates select="node()" mode="print">
     <xsl:with-param name="selectedNodes" select="$selectedNodes"/>
   </xsl:apply-templates>

  </xsl:element>
</xsl:template>

<xsl:template match="@*" mode="print">
  <xsl:param name="selectedNodes"/>
    <xsl:choose>
      <xsl:when test="count($selectedNodes | .)  = count($selectedNodes)">
       <xsl:attribute name="jj_att_{name()}">
        <xsl:value-of select="'on'"/>
       </xsl:attribute>
      </xsl:when>
      <xsl:otherwise/>
    </xsl:choose>

    <xsl:attribute name="{name()}">
      <xsl:value-of select="."/>
    </xsl:attribute>
</xsl:template>     



<xsl:template match="text()"/>

</xsl:stylesheet>





