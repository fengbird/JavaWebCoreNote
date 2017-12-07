<?xml version="1.0"?>

<xsl:stylesheet xmlns:xsl='http://www.w3.org/1999/XSL/Transform' 
xmlns:saxon="http://icl.com/saxon" 
xmlns:xlink="http://www.w3.org/1999/xlink"
extension-element-prefixes="saxon" version="1.0">

 <xsl:output 
      method="xml" indent="yes"
      doctype-public = "-//W3C//DTD SVG 20000802//EN"
      doctype-system = "http://www.w3.org/TR/2000/CR-SVG-20000802/DTD/svg-20000802.dtd"
  />
<!--       doctype-system = "file:../Standard/svg-20000802.dtd" -->


<xsl:param name="pathfile"/>
<xsl:param name="elwidth">20</xsl:param>
<xsl:param name="elheight">50</xsl:param>
<xsl:param name="attwidth">30</xsl:param>
<xsl:param name="attheight">10</xsl:param>

<!-- xsl:variable name="maximum">
</xsl:variable -->


<xsl:template match="/">
   <xsl:apply-templates/>
</xsl:template>

<xsl:template match="all">
   <xsl:apply-templates/>
</xsl:template>

<xsl:template match="ex">
  <xsl:variable name="source">
   <xsl:copy-of select="source/node()"/>
  </xsl:variable>

  <saxon:output file="Output/tr_{@id}.svg" indent="yes">
   <xsl:apply-templates select="$source" mode="printSVG">
    <xsl:with-param name="path" select="current()/path"/>
   </xsl:apply-templates>
  </saxon:output>
</xsl:template>




<xsl:template match="/" mode="printSVG">
<xsl:param name="path"/>

<xsl:variable name="orderedLevels">
 <xsl:for-each select="//*[not(*)]">
   <xsl:sort select="count(ancestor::*)" order="descending"/>
   <xsl:value-of select="count(ancestor::*)"/>
   <xsl:text>~</xsl:text>
 </xsl:for-each> 
</xsl:variable>

<xsl:variable name="svgheight"><xsl:value-of select="(number(substring-before($orderedLevels,'~')) + 1) * $elheight*1.5"/></xsl:variable>


<xsl:variable name="unorderedColumns">
 <xsl:for-each select="//*">
  <xsl:variable name="level">
   <xsl:value-of select="count(ancestor::*)"/>
  </xsl:variable>
  <!-- xsl:message>
   level: <xsl:value-of select="$level"/>
  </xsl:message -->
   <i level="{$level}">
    <xsl:value-of select="count(//*[count(ancestor::*) = $level])"/>
   </i>
 </xsl:for-each> 
</xsl:variable>

<xsl:variable name="orderedColumns">
 <xsl:for-each select="$unorderedColumns/*">
  <xsl:sort select="." data-type="number" order="descending"/>
  <!-- xsl:message>
   i: <xsl:value-of select="."/>
  </xsl:message -->
   <j>
    <xsl:value-of select="."/>
   </j>
 </xsl:for-each> 
</xsl:variable>

<xsl:variable name="svgwidth">
  <xsl:value-of select="($orderedColumns/*[1] + 1) * $elwidth*3"/>
</xsl:variable>



 <!-- xsl:message>
   orderedLevels: <xsl:value-of select="$orderedLevels"/>
   svgheight: <xsl:value-of select="$svgheight"/>
   unorderedColumns: <xsl:value-of select="$unorderedColumns"/>
   orderedColumns: <xsl:value-of select="$orderedColumns"/>
 </xsl:message -->

 <svg width="{$svgwidth}" height="{$svgheight}" xmlns:xlink="http://www.w3.org/1999/xlink">
  <defs>
        <g id="arrowMarker">
           <g stroke="black" stroke-width="1">
              <line x1="6" y1="-2" x2="0" y2="0"/>
              <line x1="6" y1="+2" x2="0" y2="0"/>
           </g>
        </g>

        <marker id="startMarker" markerWidth="36" markerHeight="24" 
                    viewBox="-4 -4 25 5" 
                    orient="auto" refX="0" refY="0"
                    markerUnits="strokeWidth">
                <g>
                <use xlink:href="#arrowMarker" transform="rotate(180)" stroke-width="1" stroke="black" />
                </g>
        </marker>


   </defs>
  <rect width="{$svgwidth}" height="{$svgheight}" x="0" y="0" fill="white" opacity="1.0"/>
 <g text-anchor="end" font-family="dialog">
  <text x="99%" y="20">
    <xsl:value-of select="$path"/>
  </text>
  <text x="99%" y="99%" font-size="8pt">
    <xsl:text>ZVON.org - XPathTutorial</xsl:text>
  </text>
 </g>
 <g>
   <xsl:apply-templates mode="tree"/>
 </g>

 </svg>
</xsl:template>



<xsl:template match="*" mode="tree">
  <xsl:param name="maxElements" select="1"/>
  <xsl:param name="parentX" select="0"/>
  <xsl:param name="parentY" select="0"/>


  <xsl:variable name="level">
   <xsl:value-of select="count(ancestor::*)"/>
  </xsl:variable>

  <xsl:variable name="elementsInThisLevel">
   <xsl:value-of select="count(//*[count(ancestor::*) = $level])"/>
  </xsl:variable>

  <!-- xsl:message>
   level: <xsl:value-of select="$level"/>
   elementsInThisLevel: <xsl:value-of select="$elementsInThisLevel"/>
   y: <xsl:value-of select="count(preceding::*[count(ancestor::*) = $level])"/>
  </xsl:message -->

  <xsl:variable name="currentY">
   <xsl:value-of select="$level*$elheight*1.5"/>
  </xsl:variable>

  <xsl:variable name="currentX">
   <xsl:value-of select="count(preceding::*[count(ancestor::*) = $level]) * $elwidth * 3"/> 
  </xsl:variable>



  <rect x="{$currentX}" 
        y="{$currentY}" 
        height="{$elheight}px" width="{$elwidth}" stroke="black">
 
    <xsl:choose>
     <xsl:when test="@jj_el">
      <xsl:attribute name="fill"><xsl:text>red</xsl:text></xsl:attribute>
     </xsl:when>
     <xsl:otherwise>
      <xsl:attribute name="fill"><xsl:text>#3399cc</xsl:text></xsl:attribute>
     </xsl:otherwise>
    </xsl:choose>

   </rect>

   <g transform="translate({$currentX}, {$currentY}) 
                 rotate(90) 
                 translate(5,-5)">
     <text y="0" 
           x="0"
           text-anchor="start" 
           fill="white" 
           font-family="sans-serif, dialog" 
           font-weight="bold">
   <xsl:value-of select="name()"/>
     </text>
   </g>


 <xsl:if test="ancestor::*">
   <line x1 = "{$parentX + $elwidth div 2}"  x2="{$currentX + $elwidth div 2}" 
         y1 = "{$parentY + $elheight + 2}" y2="{$currentY - 2}" 
         style="fill:none; stroke:black; stroke-width:1" 
         marker-end="url(#startMarker)"/>
 </xsl:if>

   <xsl:apply-templates select="@*[not(starts-with(name(),'jj_'))]" mode="tree">
    <xsl:with-param name="parentX">
     <xsl:value-of select="$currentX"/>
    </xsl:with-param>

    <xsl:with-param name="parentY">
     <xsl:value-of select="$currentY"/>
    </xsl:with-param>
   </xsl:apply-templates>




   <xsl:apply-templates mode="tree">
    <xsl:with-param name="parentX">
     <xsl:value-of select="$currentX"/>
    </xsl:with-param>

    <xsl:with-param name="parentY">
     <xsl:value-of select="$currentY"/>
    </xsl:with-param>


    <!-- xsl:with-param name="maxElements">
     <xsl:choose>
      <xsl:when test="$maxElements gt; $elementsInThisLevel">
       <xsl:value-of select="$maxElements"/>
      </xsl:when>
      <xsl:otherwise>
       <xsl:value-of select="$elementsInThisLevel"/>
      </xsl:otherwise>
     </xsl:choose>
    </xsl:with-param -->
   </xsl:apply-templates>

</xsl:template>



<!-- xsl:template match="@*" mode="copy">
   <xsl:attribute name="{name()}">
    <xsl:value-of select="."/>
   </xsl:attribute>
</xsl:template -->



<xsl:template match="@*" mode="tree">
  <xsl:param name="parentX" select="0"/>
  <xsl:param name="parentY" select="0"/>


  <xsl:variable name="currentY">
   <xsl:value-of select="$parentY + (position() - 1) * $attheight*1.5"/>
  </xsl:variable>

  <xsl:variable name="currentX">
   <xsl:value-of select="$parentX + $elwidth + 5"/> 
  </xsl:variable>

  <xsl:variable name="name">
   <xsl:value-of select="name()"/> 
  </xsl:variable>




  <rect x="{$currentX}" 
        y="{$currentY}" 
        height="{$attheight}" width="{$attwidth}">
 
    <xsl:choose>
     <xsl:when test="parent::*/@*[name() = concat('jj_att_',$name)]">
      <xsl:attribute name="stroke"><xsl:text>black</xsl:text></xsl:attribute>
      <xsl:attribute name="fill"><xsl:text>#ffcccc</xsl:text></xsl:attribute>
     </xsl:when>
     <xsl:otherwise>
      <xsl:attribute name="stroke"><xsl:text>none</xsl:text></xsl:attribute>
      <xsl:attribute name="fill"><xsl:text>none</xsl:text></xsl:attribute>
     </xsl:otherwise>
    </xsl:choose>

   </rect>

   <g transform="translate({$currentX}, {$currentY + $attheight})">
     <text y="0" 
           x="3"
           font-size="8pt"
           text-anchor="start" 
           font-weight="normal"
           font-family="sans-serif,dialog">
       <xsl:value-of select="name()"/>
     </text>
   </g>


   <line x1 = "{$parentX + $elwidth}"  x2="{$currentX}" 
         y1 = "{$currentY + $attheight div 2}" 
         y2 = "{$currentY + $attheight div 2}" 
         style="fill:none; stroke:black; stroke-width:1"/> 

</xsl:template>




</xsl:stylesheet>




