<xsl:stylesheet xmlns:xsl='http://www.w3.org/1999/XSL/Transform' xmlns:saxon="http://icl.com/saxon" extension-element-prefixes="saxon" version="1.1"> 

<xsl:import href="../../../share/XSLT/bottomLinks.xsl"/>
<xsl:import href="../../../share/XSLT/descriptionTop.xslt"/>
<xsl:import href="../../../share/XSLT/indexMenu.xslt"/>

<xsl:output method="html"/>

<xsl:param name="pwd"/>
<xsl:param name="basePath"/>
<xsl:param name="lang">eng</xsl:param>
<xsl:param name="langsuffix"/>


<xsl:variable name="zvonItemid" select="document('../Data/frontpage.xml')/frontPage/@idref"/>

<xsl:variable name="translationLabels">
<labels>
<contentsTitle>
    <text lang="ita">Contenuti</text>
    <text lang="eng">Contents</text>
    <text lang="ger">Inhalt</text>    
    <text lang="cze">Obsah</text>
    <text lang="fre">Contenu</text>
    <text lang="dut">Inhoud</text>
    <text lang="spa">Contenido</text>
    <text lang="rus">&#x421;&#x43E;&#x434;&#x435;&#x440;&#x436;&#x430;&#x43D;&#x438;&#x435;</text>
    <text lang="chi">目录</text>
</contentsTitle>
<exampleText>
    <text lang="ita">Esempio</text>
    <text lang="eng">Example</text>
    <text lang="ger">Beispiel</text>    
    <text lang="cze">P&#345;&#237;klad</text>
    <text lang="fre">Exemple</text>
    <text lang="dut">Voorbeeld</text>
    <text lang="spa">Ejemplo</text>
    <text lang="rus">&#x41F;&#x440;&#x438;&#x43C;&#x435;&#x440;</text>
    <text lang="chi">实例</text>
</exampleText>
<prev>
    <text lang="ita">Precedente</text>
    <text lang="eng">Prev</text>
    <text lang="ger">Vorheriges</text>    
    <text lang="cze">P&#345;ede&#353;l&#253;</text>
    <text lang="fre">Pr&#xE9;c&#xE9;dent</text>
    <text lang="dut">Vorig</text>
    <text lang="spa">Ant</text>
    <text lang="rus">&#x41D;&#x430;&#x437;&#x430;&#x434;</text>
    <text lang="chi">前页</text>
</prev>
<next>
    <text lang="ita">Successivo</text>
    <text lang="eng">Next</text>
    <text lang="ger">N&#228;chstes</text>    
    <text lang="cze">N&#225;sleduj&#237;c&#237;</text>
    <text lang="fre">Suivant</text>
    <text lang="dut">Volgend</text>
    <text lang="spa">Prox</text>
    <text lang="rus">&#x412;&#x43F;&#x435;&#x440;&#x435;&#x434;</text>
    <text lang="chi">后页</text>
</next>
<treeTitle>
    <text lang="ita">albero</text>
    <text lang="eng">tree</text>
    <text lang="ger">Baum</text>    
    <text lang="cze">strom</text>
    <text lang="fre">arbre</text>
    <text lang="dut">boomstructuur</text>
    <text lang="spa">&#xE1;rbol</text>
    <text lang="rus">&#x434;&#x435;&#x440;&#x435;&#x432;&#x43E;</text>
    <text lang="chi">树</text>
</treeTitle>
<treeViewTitle>
    <text lang="ita">Vista ad albero</text>
    <text lang="eng">Tree view</text>
    <text lang="ger">Baumansicht</text>    
    <text lang="cze">Zobrazen&#237; jako strom</text>
    <text lang="fre">vue d'arbre</text>
    <text lang="dut">Boomstructuur weergave</text>
    <text lang="spa">Vista arborescente</text>
    <text lang="rus">&#x41A;&#x430;&#x43A; &#x434;&#x435;&#x440;&#x435;&#x432;&#x43E;</text>
    <text lang="chi">树视图</text>
</treeViewTitle>
<sampleText>
    <text lang="ita">Esempio</text>
    <text lang="eng">Sample</text>
    <text lang="ger">Beispiel</text>    
    <text lang="cze">Vzorek</text>
    <text lang="fre">Echantillon</text>
    <text lang="dut"></text>
    <text lang="spa">Muestra</text>
    <text lang="rus">&#x412;&#x44B;&#x431;&#x43E;&#x440;&#x43A;&#x430;</text>
    <text lang="chi">样例</text>
</sampleText>
<xlabLinkTitle>
    <text lang="ita">Apri l'esempio in XLab.</text>
    <text lang="eng">Open the example in XLab.</text>
    <text lang="ger">&#214;ffne das Beispiel in XLab.</text>    
    <text lang="cze">Otev&#345;&#237;t p&#345;&#237;klad v XLabu.</text>
    <text lang="fre">Ouvrez l'exemple dans XLab</text>
    <text lang="dut">Open het voorbeeld in Xlab</text>
    <text lang="spa">Abrir el ejemplo en XLab.</text>
    <text lang="rus">&#x41E;&#x442;&#x43A;&#x440;&#x44B;&#x442;&#x44C; &#x43F;&#x440;&#x438;&#x43C;&#x435;&#x440; &#x432; XLab</text>
    <text lang="chi">在XLab中打开实例</text>
</xlabLinkTitle>
<gotoExampleTitle>
    <text lang="ita">Vai all'esempio</text>    
    <text lang="eng">Go to example</text>
    <text lang="ger">Gehe zum Beispiel</text>    
    <text lang="cze">Zp&#283;t na p&#345;&#237;klad</text>
    <text lang="fre">Allez &#xE0; l'exemple</text>
    <text lang="dut">Naar het voorbeeld</text>
    <text lang="spa">Ir al ejemplo</text>
    <text lang="rus">&#x412;&#x435;&#x440;&#x43D;&#x443;&#x442;&#x44C;&#x441;&#x44F; &#x43A; &#x43F;&#x440;&#x438;&#x43C;&#x435;&#x440;&#x443;</text>
    <text lang="chi">转到实例</text>
</gotoExampleTitle>

</labels>
</xsl:variable>




<xsl:variable name="menu">
  <xsl:choose>
    <xsl:when test="$lang = 'cze'">
      <groups xmlns="">
	<group id="examples" href="./examples.html" title="P&#345;&#237;klady"/>
	<group id="paths"  href="./paths.html"  title="XPath v&#253;razy"/>
      </groups>
    </xsl:when>
    <xsl:when test="$lang = 'rus'">
      <groups xmlns="">
	<group id="examples" href="./examples.html" title="&#x41F;&#x440;&#x438;&#x43C;&#x435;&#x440;&#x44B;"/>
	<group id="paths"  href="./paths.html"  title="&#x412;&#x44B;&#x440;&#x430;&#x436;&#x435;&#x43D;&#x438;&#x44F; XPath"/>
      </groups>
    </xsl:when>
     <xsl:when test="$lang = 'cze'">
      <groups xmlns="">
	<group id="examples" href="./examples.html" title="实例"/>
	<group id="paths"  href="./paths.html"  title="XPaths"/>
      </groups>
    </xsl:when>
    <xsl:otherwise>
      <groups xmlns="">
	<group id="examples" href="./examples.html" title="Examples"/>
	<group id="paths"  href="./paths.html"  title="XPaths"/>
      </groups>
    </xsl:otherwise>
  </xsl:choose>
</xsl:variable>


<xsl:key name="id" match="XPathTutorial/@id" use="."/>

<xsl:variable name="tab">&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;</xsl:variable> 


<xsl:template match="xm_sources">
  <html>
    <head>
      <title>XPath Tutorial</title>
    </head>
    <frameset cols="350,*">
      <frame name="mainIndex" src="../Output{$langsuffix}/examples.html"/>
      <frame name="mainWindow" src="../Output{$langsuffix}/introduction.html"/>
    </frameset>
  </html>
      
  <saxon:output file="{$pwd}Output{$langsuffix}/examples.html">
    <html>
      <head>
	<link rel="stylesheet" type="text/css" href="../CSS/tutorial.css"/>
	<title>XPath Tutorial</title>
      </head>
      <body>

	<xsl:call-template name="index-header">
	  <xsl:with-param name="on">examples</xsl:with-param>
	  <xsl:with-param name="id" select="$zvonItemid"/>
	  <xsl:with-param name="lang" select="$lang"/>
	  <xsl:with-param name="multilang">yes</xsl:with-param>
	  <xsl:with-param name="languages">
	    <language lang="eng" href="../Output/examples.html"/>
	    <language lang="cze" href="../Output_cze/examples.html"/>
	    <language lang="dut" href="../Output_dut/examples.html"/>
	    <language lang="fre" href="../Output_fre/examples.html"/>
	    <language lang="spa" href="../Output_spa/examples.html"/>
	    <language lang="rus" href="../Output_rus/examples.html"/>
	    <language lang="ger" href="../Output_ger/examples.html"/>
	    <language lang="chi" href="../Output_chi/examples.html"/>
	    <language lang="ita" href="../Output_ita/examples.html"/>
	  </xsl:with-param>
	  <xsl:with-param name="languageTarget">_self</xsl:with-param>
	</xsl:call-template>

	<table border="1" width="100%" cellpadding="1">
	  <xsl:apply-templates select="//XPathTutorial" mode="index">
	    <xsl:sort data-type = "number" select="@id"/>
	  </xsl:apply-templates>
	</table>
      </body>
    </html>
  </saxon:output>


  <saxon:output file="{$pwd}Output{$langsuffix}/paths.html">
    <html>
      <head>
	<link rel="stylesheet" type="text/css" href="../CSS/tutorial.css"/>
	<title>XPath Tutorial</title>
      </head>
      <body>

	<xsl:call-template name="index-header">
	  <xsl:with-param name="on">paths</xsl:with-param>
	  <xsl:with-param name="id" select="$zvonItemid"/>
	  <xsl:with-param name="lang" select="$lang"/>
	  <xsl:with-param name="multilang">yes</xsl:with-param>
	  <xsl:with-param name="languages">
	    <language lang="eng" href="../Output/paths.html"/>
	    <language lang="cze" href="../Output_cze/paths.html"/>
	    <language lang="dut" href="../Output_dut/paths.html"/>
	    <language lang="fre" href="../Output_fre/paths.html"/>
	    <language lang="spa" href="../Output_spa/paths.html"/>
	    <language lang="rus" href="../Output_rus/paths.html"/>
	    <language lang="ger" href="../Output_ger/paths.html"/>
	    <language lang="chi" href="../Output_chi/paths.html"/>
	    <language lang="ita" href="../Output_ita/paths.html"/>
	  </xsl:with-param>
	  <xsl:with-param name="languageTarget">_self</xsl:with-param>
	</xsl:call-template>

	<table border="1" width="100%" cellpadding="1">
	  <xsl:apply-templates select="//example" mode="index">
	    <xsl:sort select="string-length(@path)" data-type="number"/>
	  </xsl:apply-templates>
	</table>
      </body>
    </html>
  </saxon:output>

 <!-- write source files for XLab -->
  <xsl:for-each select="XPathTutorial/source">
   <saxon:output file="{$pwd}../../cgi-bin/XLab/XML/xpatut_{parent::*/@id}.html">
    <xsl:copy-of select="node()"/>
   </saxon:output>
  </xsl:for-each>

</xsl:template> 



<xsl:template match="example" mode="index">
  <xsl:variable name="position">
   <xsl:value-of select="count(preceding-sibling::example)"/>
  </xsl:variable>
  <tr>
    <td>
      <a class="xpath" href="example{parent::XPathTutorial/@id}.html#{generate-id()}" target="mainWindow"><xsl:value-of select="@path"/></a>

      &#160;&#160; 
      (<a href="example{parent::XPathTutorial/@id}_{$position}_png.html" target="mainWindow"><xsl:value-of select="$translationLabels/labels/treeTitle/text[@lang = $lang]"/></a>)
    </td>
  </tr>

  <saxon:output file="{$pwd}Output{$langsuffix}/example{parent::XPathTutorial/@id}_{$position}_png.html">
    <html>
      <head>
	<link rel="stylesheet" type="text/css" href="../CSS/tutorial.css"/>
	<title>XPath Tutorial</title>
	<link rel="index" href="index.html"/>
	<link rel="up" href="example{parent::XPathTutorial/@id}.html"/>
      </head>
      <body>


	<xsl:call-template name="share_descriptionTop">
	  <xsl:with-param name="id" select="$zvonItemid"/>
	  <xsl:with-param name="lang" select="$lang"/>
	  <xsl:with-param name="multilang">yes</xsl:with-param>
	  <xsl:with-param name="languages">
	    <language lang="eng" href="../Output/example{parent::XPathTutorial/@id}_{$position}_png.html"/>
	    <language lang="cze" href="../Output_cze/example{parent::XPathTutorial/@id}_{$position}_png.html"/>
	    <language lang="dut" href="../Output_dut/example{parent::XPathTutorial/@id}_{$position}_png.html"/>
	    <language lang="fre" href="../Output_fre/example{parent::XPathTutorial/@id}_{$position}_png.html"/>
	    <language lang="spa" href="../Output_spa/example{parent::XPathTutorial/@id}_{$position}_png.html"/>
	    <language lang="rus" href="../Output_rus/example{parent::XPathTutorial/@id}_{$position}_png.html"/>
	    <language lang="ger" href="../Output_ger/example{parent::XPathTutorial/@id}_{$position}_png.html"/>
	    <language lang="chi" href="../Output_chi/example{parent::XPathTutorial/@id}_{$position}_png.html"/>
	    <language lang="ita" href="../Output_ita/example{parent::XPathTutorial/@id}_{$position}_png.html"/>
	  </xsl:with-param>
	  <xsl:with-param name="languageTarget">_self</xsl:with-param>
	</xsl:call-template>

	<table class="hangingMenu" border="0" cellpadding="1" cellspacing="0" width="100%">
	  <tr>
	    <td>
	      <a class='naviBlack' href='example{parent::XPathTutorial/@id}.html'><xsl:value-of select="$translationLabels/labels/exampleText/text[@lang = $lang]"/><xsl:text> </xsl:text><xsl:value-of select="parent::XPathTutorial/@id"/></a>
	      >
	      <b><xsl:value-of select="$translationLabels/labels/sampleText/text[@lang = $lang]"/><xsl:text> </xsl:text><xsl:value-of select="$position + 1"/></b>
	    </td>
	  </tr>
	</table>
	<br/>

	<h3><xsl:value-of select="$translationLabels/labels/treeViewTitle/text[@lang = $lang]"/></h3>
	<img src="../Output/tr_{parent::*/@id}_{$position}.jpg">
	 <xsl:attribute name="alt">
	   <xsl:value-of select="$translationLabels/labels/exampleText/text[@lang = $lang]"/>
	 </xsl:attribute>
       </img>
	<xsl:apply-templates select="." mode="single_description"/>
       <xsl:call-template name="bottomLinks"/>     
      </body>
    </html>
  </saxon:output>

</xsl:template>



<xsl:template match="XPathTutorial" mode="index">
  <tr>
    <td>
      <a class="example" href="example{@id}.html" target="mainWindow"><xsl:value-of select="$translationLabels/labels/exampleText/text[@lang = $lang]"/><xsl:text> </xsl:text><xsl:value-of select="@id"/></a>
      <br/>  
      <xsl:apply-templates select="description"/>
    </td>
  </tr>
  <xsl:apply-templates select="." mode="description"/>
</xsl:template>


<xsl:template match="text()" mode="splitPath">
  <xsl:value-of select="concat(' | ','preceding-sibling::source',.)"/>
</xsl:template>


<xsl:template name="parsePath">
  <xsl:variable name="path">
    <xsl:apply-templates select="saxon:tokenize(@path,'|')" mode="splitPath"/>
  </xsl:variable>

  <!-- xsl:message>
    path: <xsl:value-of select="@path"/>
  </xsl:message -->

  <xsl:apply-templates select="preceding-sibling::source/node()" mode="print">
    <xsl:with-param name="selectedNodes" select="saxon:evaluate(substring-after($path,'|'))"/>
    </xsl:apply-templates>
</xsl:template>


<xsl:template match="example" mode="description">
  <xsl:variable name="position">
   <xsl:value-of select="count(preceding-sibling::example)"/>
  </xsl:variable>


  <div><a name="{generate-id()}"/>&#160;</div>
  <table border="1"  cellpadding="5" width="85%">
    <tr>
      <th>  <xsl:value-of select="@path"/></th>
    </tr>
    <tr>
      <td><xsl:apply-templates/></td>
    </tr>
    <tr>
      <td class="code">
	<xsl:call-template name="parsePath"/>
      </td>
    </tr>
    <tr>
     <td>
      <xsl:apply-templates select="preceding-sibling::source" mode="XLablink">
       <xsl:with-param name="XPath" select="@path"/>
      </xsl:apply-templates>
  
      <xsl:text> | </xsl:text>

      <a href="example{parent::XPathTutorial/@id}_{$position}_png.html"><xsl:value-of select="$translationLabels/labels/treeViewTitle/text[@lang = $lang]"/> (JPG)</a>
     </td>
    </tr>
  </table>
</xsl:template>



<xsl:template match="example" mode="single_description">
  <xsl:variable name="position">
   <xsl:value-of select="count(preceding-sibling::example)"/>
  </xsl:variable>

  <div><a name="{generate-id()}"/>&#160;</div>
  <table border="1"  cellpadding="5" width="85%">
    <tr>
      <th>  <xsl:value-of select="@path"/></th>
    </tr>
    <tr>
      <td><xsl:apply-templates/></td>
    </tr>
    <tr>
      <td class="code">
	<xsl:call-template name="parsePath"/>
      </td>
    </tr>
    <tr>
     <td>
      <xsl:apply-templates select="preceding-sibling::source" mode="XLablink">
       <xsl:with-param name="XPath" select="@path"/>
      </xsl:apply-templates>
  
      <xsl:text> | </xsl:text>

      <a href="example{parent::XPathTutorial/@id}.html"><xsl:value-of select="$translationLabels/labels/gotoExampleTitle/text[@lang = $lang]"/></a>
     </td>
    </tr>
  </table>
</xsl:template>





<xsl:template match="XPathTutorial" mode="description">
  <xsl:variable name="previous">
    <xsl:choose>
      <xsl:when test="@id=1">1</xsl:when>
      <xsl:otherwise><xsl:value-of select="@id - 1"/></xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="next">
    <xsl:choose>
      <xsl:when test="not(key('id',@id+1))">1</xsl:when>
      <xsl:otherwise><xsl:value-of select="@id + 1"/></xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

    <saxon:output file="{$pwd}Output{$langsuffix}/example{@id}.html">
    <html>
      <head>
	<link rel="stylesheet" type="text/css" href="../CSS/tutorial.css"/>
	<title>XPath Tutorial</title>
        <link rel="index" href="index.html"/>
        <link rel="previous" href='example{$previous}.html'/>
        <link rel="next" href='example{$next}.html'/>
      </head>
      <body>

	<xsl:call-template name="share_descriptionTop">
	  <xsl:with-param name="id" select="$zvonItemid"/>
	  <xsl:with-param name="lang" select="$lang"/>
	  <xsl:with-param name="multilang">yes</xsl:with-param>
	  <xsl:with-param name="languages">
	    <language lang="eng" href="../Output/example{@id}.html"/>
	    <language lang="cze" href="../Output_cze/example{@id}.html"/>
	    <language lang="dut" href="../Output_dut/example{@id}.html"/>
	    <language lang="fre" href="../Output_fre/example{@id}.html"/>
	    <language lang="spa" href="../Output_spa/example{@id}.html"/>
	    <language lang="rus" href="../Output_rus/example{@id}.html"/>
	    <language lang="ger" href="../Output_ger/example{@id}.html"/>
	    <language lang="chi" href="../Output_chi/example{@id}.html"/>
	    <language lang="ita" href="../Output_ita/example{@id}.html"/>
	  </xsl:with-param>
	  <xsl:with-param name="languageTarget">_self</xsl:with-param>
	</xsl:call-template>

	<table class="hangingMenu" border="0" cellpadding="1" cellspacing="0" width="100%">
	  <tr>
	    <td>
	      <b>>> <xsl:value-of select="$translationLabels/labels/exampleText/text[@lang = $lang]"/><xsl:text> </xsl:text><xsl:value-of select="@id"/> &lt;&lt;</b>
		|
<a class='naviBlack' href='example{$previous}.html'><xsl:value-of select="$translationLabels/labels/prev/text[@lang = $lang]"/></a>
		|
<a class='naviBlack' href='example{$next}.html'><xsl:value-of select="$translationLabels/labels/next/text[@lang = $lang]"/></a>
	    </td>
	  </tr>
	</table>
	<br/>
	<div class="description">
	  <xsl:apply-templates select="description"/>
	</div>
	<xsl:apply-templates select="example" mode="description"/>

       <xsl:call-template name="bottomLinks"/>     

      </body>
    </html>
  </saxon:output>
</xsl:template>


<xsl:template match="*" mode="print">
  <xsl:param name="selectedNodes"/>

  <xsl:variable name="element">
    <xsl:choose>
      <xsl:when test="count($selectedNodes | .)  = count($selectedNodes)">
	<xsl:text>elementOn</xsl:text>
      </xsl:when>
      <xsl:otherwise>element</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <!-- xsl:if test="ancestor::XPathTutorial/@id = '21'">
    <xsl:message>
      element name: <xsl:value-of select="name()"/>
      $element    : <xsl:value-of select="$element"/>
    </xsl:message>
  </xsl:if -->

  <xsl:variable name="indent" select="substring($tab,1,(count(ancestor::*)-2)*5)"/>
  <br/>
  <xsl:value-of select="$indent"/>
  <xsl:text>&lt;</xsl:text>

  <span class="{$element}">
    <xsl:value-of select="name()"/>
  </span>
  <xsl:apply-templates select="@*" mode="print">
    <xsl:with-param name="selectedNodes" select="$selectedNodes"/>
  </xsl:apply-templates>
  
  <xsl:choose>
    <xsl:when test="node()">
      <xsl:text>&gt;</xsl:text>
      <xsl:apply-templates mode="print">
	<xsl:with-param name="selectedNodes" select="$selectedNodes"/>
      </xsl:apply-templates>
      <xsl:if test="*">
	<br/>
	<xsl:value-of select="$indent"/>
      </xsl:if>
      <xsl:text>&lt;/</xsl:text>
      <span class="{$element}">
	<xsl:value-of select="name()"/>
      </span>
      <xsl:text>&gt;</xsl:text>
    </xsl:when>
    <xsl:otherwise>/&gt;</xsl:otherwise>
</xsl:choose>
  

</xsl:template>

<xsl:template match="@*" mode="print">
  <xsl:param name="selectedNodes"/>
  <xsl:variable name="element">
    <xsl:choose>
      <xsl:when test="count($selectedNodes | .)  = count($selectedNodes)">
	<xsl:text>elementOn</xsl:text>
      </xsl:when>
      <xsl:otherwise>element</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <span class="{$element}">
    <xsl:text> </xsl:text>
    <xsl:value-of select="name()"/>
    <xsl:text> = "</xsl:text>
    <xsl:value-of select="."/>
    <xsl:text>"</xsl:text>
  </span>
</xsl:template>     



<xsl:template match="source" mode="XLablink">
  <xsl:param name="XPath"/>

  <a target="_top">
   <xsl:attribute name="href">
    <xsl:text>http://www.zvon.org:9001/saxon/cgi-bin/XLab/XML/</xsl:text>
    <xsl:text>xpatut_</xsl:text>
    <xsl:value-of select="parent::*/@id"/>
    <xsl:text>.html?stylesheetFile=XSLT/xpath.xslt&amp;value=</xsl:text>
    <xsl:value-of select="$XPath"/>

    <!-- XLabs translated -->
    <xsl:if test="$lang = 'eng' or $lang = 'cze' or $lang = 'dut' or $lang = 'spa'">
      <xsl:text>&amp;lang=</xsl:text>
      <xsl:value-of select="$lang"/>
    </xsl:if>

    <!-- xsl:value-of select="concat('xpatut_',parent::*/@id,'.html?stylesheetFile=XSLT/xpath.xslt&amp;value=',$XPath,'&amp;lang=',$lang)"/ -->
   </xsl:attribute>
   <xsl:value-of select="$translationLabels/labels/xlabLinkTitle/text[@lang = $lang]"/>

  </a>
</xsl:template>     



<xsl:template match="text()"/>



<xsl:template match="description | p">
  <xsl:choose>
    <xsl:when test="@lang = $lang">
      <xsl:value-of select="."/>      
    </xsl:when>
    <xsl:otherwise/>
  </xsl:choose>
</xsl:template>



</xsl:stylesheet>





