<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0" version="1.0">
	<xsl:output method="html" encoding="UTF-8" indent="yes"/>

	<!-- TEMPLATE STRUTTURA -->
	<xsl:template match="/">
		<html>
			<head>
				<title>
					<xsl:value-of select="//tei:titleStmt/tei:title"/>
				</title>
				<xsl:element name="meta">
					<xsl:attribute name="name">author</xsl:attribute>
					<xsl:attribute name="content">
						<xsl:value-of select="//tei:titleStmt/tei:respStmt[1]/tei:name"/>
					</xsl:attribute>
				</xsl:element>
				<script src="script.js"></script>
				<link rel = "stylesheet" href="style.css"/>
			</head>
			<body>
				<header style="position: fixed; left: 37.5%; top: 0;">
					<h1>
						<xsl:value-of select="//tei:titleStmt/tei:title"/>
					</h1>
				</header>
				<div style="margin-top: 150px; margin-bottom: 10px;" class="notCard">
					<h3>Pubblicazione ed edizione</h3>
					<p>
						Edizione digitale di <xsl:value-of select="count(/tei:TEI/tei:TEI)"/> cartoline, inviate durante la prima guerra mondiale, appartenenti a una collezione di proprietà del <xsl:value-of select="//tei:titleStmt/tei:respStmt[2]/tei:name"/>.
					</p>
					<p>
						Pubblicato a <xsl:value-of select="//tei:publicationStmt/tei:pubPlace"/> nel <xsl:value-of select="//tei:publicationStmt/tei:date"/> da	<xsl:value-of select="//tei:publicationStmt/tei:address/tei:addrLine"/>.
					</p>
					<p>
						Trascrizione digitale del <xsl:value-of select="//tei:editionStmt/tei:edition/tei:date"/> a opera degli <xsl:value-of select="//tei:editionStmt/tei:edition/node()[1]"/>.<br/>
						<h4>Persone coinvolte</h4>
						<table>
							<tr><th>Ruolo</th><th>Persona</th></tr>
							<tr>
								<td><xsl:value-of select="//tei:titleStmt/tei:respStmt[1]/tei:resp"/></td>
								<td><xsl:value-of select="//tei:titleStmt/tei:respStmt[1]/tei:name"/></td>
							</tr>
							<xsl:for-each select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:editionStmt/tei:respStmt/tei:name">
								<tr>
									<td><xsl:value-of select="../tei:resp"/></td>
									<td><xsl:value-of select="."/></td>
								</tr>
							</xsl:for-each>
						</table>
					</p>
				</div>
				<xsl:element name="div">
					<xsl:attribute name="class">card</xsl:attribute>
					<xsl:attribute name="id"><xsl:value-of select="/tei:TEI/tei:TEI[1]/@xml:id"/></xsl:attribute>
					<h2><xsl:value-of select="/tei:TEI/tei:TEI[1]/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title"/></h2>
					<button type="button" onclick="cambia_da_cartolina(this.parentNode.getAttribute('id'))">Passa all'altra cartolina</button>
					<xsl:apply-templates select="/tei:TEI/tei:TEI[1]"/>
				</xsl:element>
				<xsl:element name="div">
					<xsl:attribute name="class">card</xsl:attribute>
					<xsl:attribute name="id"><xsl:value-of select="/tei:TEI/tei:TEI[2]/@xml:id"/></xsl:attribute>
					<h2><xsl:value-of select="/tei:TEI/tei:TEI[2]/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title"/></h2>
					<button type="button" onclick="cambia_da_cartolina(this.parentNode.getAttribute('id'))">Passa all'altra cartolina</button>
					<xsl:apply-templates select="/tei:TEI/tei:TEI[2]"/>
				</xsl:element>
				<div style="margin-top: 10px; margin-bottom: 150px;" class="notCard">
					<h3>Appendice</h3>
					<div style="float:left; display:block; width: 49.5%; margin-right: 1%;">
						<h4>Persone</h4>
						<xsl:for-each select="//tei:person">
							<xsl:element name="div">
								<xsl:attribute name="id"><xsl:value-of select="./@xml:id"/></xsl:attribute>
								<xsl:attribute name="class">persPlace</xsl:attribute>
								<h5><xsl:apply-templates select="./tei:persName/*"/></h5>
								<p>
									<xsl:choose>
										<xsl:when test="./tei:sex[text()='M']">Uomo</xsl:when>
										<xsl:when test="./tei:sex[text()='F']">Donna</xsl:when>
									</xsl:choose>
									<xsl:if test="./tei:occupation">
										, 
										<xsl:value-of select="./tei:occupation"/>
										<xsl:if test="./tei:occupation[text()='maggiore']">
											del Regio Esercito Italiano
										</xsl:if>
									</xsl:if>
									<xsl:choose>
										<xsl:when test="./@xml:id='GC'">, innamorato di <a href="#OT">Oliva Turtura</a>.</xsl:when>
										<xsl:when test="./@xml:id='OT'">, innamorata di <a href="#GC">Giovanni Coliola</a>.</xsl:when>
										<xsl:when test="./@xml:id='TC'">, autore della cartolina 7694-113 intitolata [Donna sdraiata].</xsl:when>
										<xsl:when test="./@xml:id='AM'">, autore della cartolina 7694-119 intitolata [Donna in nero con cappello rosso].</xsl:when>
									</xsl:choose>
								</p>
							</xsl:element>
						</xsl:for-each>
					</div>
					<div style="float:left; display:block; width: 49.5%;">
						<h4>Città</h4>
						<xsl:for-each select="//tei:place">
							<xsl:element name="div">
								<xsl:attribute name="id"><xsl:value-of select="./@xml:id"/></xsl:attribute>
								<xsl:attribute name="class">persPlace</xsl:attribute>
								<h5><xsl:value-of select="./tei:placeName"/></h5>
								<p>
									<xsl:choose>
										<xsl:when test="./@xml:id='RV'">Città dove abita <a href="#OT">Oliva Turtura</a>.</xsl:when>
										<xsl:when test="./@xml:id='MO'">Città dove è stanziato <a href="#GC">Giovanni Coliola</a> al momento della scrittura delle cartoline.</xsl:when>
										<xsl:when test="./@xml:id='MI'">Città dove è stata stampata la cartolina 7694-113 intitolata [Donna sdraiata] di <a href="#TC">T. Corbella</a>.</xsl:when>
										<xsl:when test="./@xml:id='SP'">Città dove è conservata la collezione di cartoline della prima guerra mondiale presa in analisi.</xsl:when>
									</xsl:choose>
								</p>
							</xsl:element>
						</xsl:for-each>
					</div>
					<div style="clear:both"></div>
				</div>
				<footer style="position: fixed; left: 37.5%; bottom: 0;">
					<p>
						<xsl:for-each select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:respStmt">
							<xsl:value-of select="tei:resp"/>: <xsl:value-of select="tei:name"/><br/>
						</xsl:for-each>
						Copyright: <xsl:value-of select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:publicationStmt/tei:availability"/>
					</p>
				</footer>
			</body>
		</html>
	</xsl:template>

	<!-- TEMPLATE CARTOLINA SINGOLA -->
	<xsl:template match="tei:TEI/tei:TEI">
		<div>
			<h3>Informazioni</h3>
			<xsl:apply-templates select="tei:teiHeader"/>
		</div>
		<div>
			<h3>Cartolina</h3>
			<div style="float:left; display:block; width: 60%">	
				<xsl:apply-templates select="tei:facsimile"/>
			</div>
			<div style="float:left; display:block; width: 40%">
				<div>
					<xsl:apply-templates select="tei:text"/>
				</div>
			</div>
			<div style="clear:both"></div>
		</div>
	</xsl:template>
	<xsl:template match="tei:teiHeader">
		<div style="float:left; display:block; width: 30%; margin-right:2%; padding: 1%;">
			<h4>Documento</h4>
			<p>
				Lo stato di conservazione del documento è <xsl:value-of select=".//tei:condition"/>: si tratta di una <xsl:value-of select=".//tei:support/tei:objectType"/> in <xsl:value-of select=".//tei:support/tei:material"/> di dimensioni <xsl:value-of select=".//tei:height"/>&#215;<xsl:value-of select=".//tei:width"/> <xsl:value-of select=".//tei:support/tei:dimensions/@unit"/>
				<xsl:if test=".//tei:support/tei:stamp">
					, con apposto <xsl:value-of select="//tei:support/tei:stamp"/> annullato il <xsl:value-of select=".//tei:correspAction/tei:date[@type='postage']"/>
				</xsl:if>
				.<br/>
				La <xsl:value-of select=".//tei:summary"/> intitolata <xsl:value-of select=".//tei:bibl/tei:title"/>, del disegnatore
				<xsl:element name="a">
					<xsl:attribute name="href"><xsl:value-of select=".//tei:bibl/tei:author/@ref"/></xsl:attribute>
					<xsl:value-of select=".//tei:bibl/tei:author"/>
				</xsl:element>
			<xsl:if test=".//tei:bibl/tei:pubPlace and .//tei:bibl/tei:date">
				stampata a <a href="#MI"><xsl:value-of select=".//tei:bibl/tei:pubPlace"/></a> il <xsl:value-of select=".//tei:bibl/tei:date"/>
			</xsl:if>,
			è conservata presso <xsl:value-of select=".//tei:repository"/> di <xsl:value-of select=".//tei:msIdentifier/tei:settlement"/> con identificativo <xsl:value-of select=".//tei:idno"/>.
			</p>
		</div>
		<div style="float:left;	display: block; width: 30%; margin-right:2%; padding: 1%;">
			<h4>Corrispondenza</h4>
			<p>
			<xsl:variable name="space"><![CDATA[&#32;]]></xsl:variable>
			La <xsl:value-of select="///tei:objectDesc//tei:support/tei:objectType"/> è stata spedita dal <xsl:value-of select="/tei:TEI//tei:fileDesc//tei:listPerson/tei:person[@xml:id='GC']/tei:occupation"/><xsl:value-of select="$space" disable-output-escaping="yes"/><a href="#GC"><xsl:value-of select="/tei:TEI//tei:fileDesc//tei:listPerson/tei:person[@xml:id='GC']/tei:persName/tei:forename"/><xsl:value-of select="$space" disable-output-escaping="yes"/><xsl:value-of select="/tei:TEI//tei:fileDesc//tei:listPerson/tei:person[@xml:id='GC']/tei:persName/tei:surname"/></a> il <xsl:value-of select="tei:profileDesc//tei:correspAction[@type='sent']/tei:date[@type='writing']"/> da <xsl:value-of select="/tei:TEI//tei:fileDesc//tei:listPlace/tei:place[@xml:id='MO']/tei:district[@type='comune']"/> ed è stata ricevuta da <a href="#OT"><xsl:value-of select="/tei:TEI//tei:fileDesc//tei:listPerson/tei:person[@xml:id='OT']/tei:persName"/></a>
			<xsl:if test=".//tei:correspAction[@type='received']/tei:placeName">
				presso <xsl:value-of select="/tei:TEI//tei:fileDesc//tei:listPlace/tei:place[@xml:id='RV']/tei:district[@type='comune']"/>
			</xsl:if>.
			</p>
		</div>
		<div style="float:left;	display: block; width: 30%; padding: 1%;">
			<h4>Note</h4>
			<xsl:for-each select=".//tei:notesStmt/tei:note">
				<p><xsl:apply-templates/></p>
			</xsl:for-each>
		</div>
		<div style="clear:both"></div>
	</xsl:template>
	<xsl:template match="tei:facsimile">
		<xsl:choose>
			<xsl:when test="../@xml:id = 'c7694-113'">
				<h4>Scannerizzazione</h4>
				<div style="float:left; display:block; width: 49.5%; margin-right: 1%;">
					<h5>Fronte</h5>
					<div style="position: relative; width: 100%;">
						<xsl:element name="img">
							<xsl:attribute name="src">
								<xsl:value-of select="tei:surface[@xml:id='c113_fronte']/tei:graphic/@url"/>
							</xsl:attribute>
							<xsl:attribute name="style">width: 100%;</xsl:attribute>
						</xsl:element>
						<xsl:apply-templates select="tei:surface[@xml:id='c113_fronte']"/>
					</div>
				</div>
				<div style="float:left; display:block; width: 49.5%;">
					<h5>Retro</h5>
					<div style="position: relative; width: 100%;">
						<xsl:element name="img">
							<xsl:attribute name="src">
								<xsl:value-of select="tei:surface[@xml:id='c113_retro']/tei:graphic/@url"/>
							</xsl:attribute>
							<xsl:attribute name="style">width: 100%;</xsl:attribute>
						</xsl:element>
						<xsl:apply-templates select="tei:surface[@xml:id='c113_retro']"/>
					</div>
				</div>
			</xsl:when>
			<xsl:when test="../@xml:id = 'c7694-119'">
				<h4>Scannerizzazione</h4>
				<div style="float:left; display:block; width: 49.5%; margin-right: 1%;">
					<h5>Fronte</h5>
					<div style="position: relative; width: 100%;">
						<xsl:element name="img">
							<xsl:attribute name="src">
								<xsl:value-of select="tei:surface[@xml:id='c119_fronte']/tei:graphic/@url"/>
							</xsl:attribute>
							<xsl:attribute name="style">width: 100%;</xsl:attribute>
						</xsl:element>
						<xsl:apply-templates select="tei:surface[@xml:id='c119_fronte']"/>
					</div>
				</div>
				<div style="float:left; display:block; width: 49.5%;">
					<h5>Retro</h5>
					<div style="position: relative; width: 100%;">
						<xsl:element name="img">
							<xsl:attribute name="src">
								<xsl:value-of select="tei:surface[@xml:id='c119_retro']/tei:graphic/@url"/>
							</xsl:attribute>
							<xsl:attribute name="style">width: 100%;</xsl:attribute>
						</xsl:element>
						<xsl:apply-templates select="tei:surface[@xml:id='c119_retro']"/>
					</div>
				</div>
			</xsl:when>
		</xsl:choose>
		<div style="clear:both"></div>
	</xsl:template>
	<xsl:template match="tei:text">
		<h4>Trascrizione</h4>
		<button type="button" onclick="cambia_edizione()" id="bottone_edizioni">Passa all'edizione interpretativa</button>
		<div>
			<h5>Fronte</h5>
			Immagine: <xsl:value-of select="tei:body/tei:div[@type='fronte']//tei:head"/> <br/>
			<xsl:value-of select="tei:body/tei:div[@type='fronte']//tei:figDesc"/> a opera di
			<xsl:element name="a">
				<xsl:attribute name="class">riga</xsl:attribute>
				<xsl:attribute name="href">
					<xsl:choose>
						<xsl:when test="../@xml:id='c7694-113'">#TC</xsl:when>
						<xsl:when test="../@xml:id='c7694-119'">#AM</xsl:when>
					</xsl:choose>
				</xsl:attribute>
				<xsl:choose>
					<xsl:when test="../@xml:id='c7694-113'">
						<xsl:attribute name="id">c113_autore_riga</xsl:attribute>
						<xsl:attribute name="onmouseover">mouse_sul_testo('c113_autore_riga')</xsl:attribute>
						<xsl:attribute name="onmouseout">mouse_via_testo('c113_autore_riga')</xsl:attribute>
					</xsl:when>
					<xsl:when test="../@xml:id='c7694-119'">
						<xsl:attribute name="id">c119_autore_riga</xsl:attribute>
						<xsl:attribute name="onmouseover">mouse_sul_testo('c119_autore_riga')</xsl:attribute>
						<xsl:attribute name="onmouseout">mouse_via_testo('c119_autore_riga')</xsl:attribute>
					</xsl:when>
				</xsl:choose>
				<xsl:value-of select="tei:body/tei:div[@type='fronte']/tei:p"/>
			</xsl:element>
		</div>
		<div>
			<h5>Retro</h5>
				<div>
					<xsl:apply-templates select="tei:body/tei:div[@type='retro']/tei:div[@type='message']"/>
				</div>
				<div>
					<xsl:apply-templates select="tei:body/tei:div[@type='retro']/tei:div[@type='destination']"/>
				</div>
		</div>
	</xsl:template>
	<xsl:template match="tei:div[@type='message']">
		<p>
			<xsl:apply-templates select="tei:opener"/>
		</p>
		<p>
			<xsl:apply-templates select="tei:p"/>
		</p>
		<p>
			<xsl:apply-templates select="tei:closer"/>
		</p>
		<xsl:if test=".//tei:postscript">
			<p>
				<xsl:apply-templates select="tei:postscript"/>
			</p>
		</xsl:if>
	</xsl:template>
	<xsl:template match="tei:div[@type='destination']">
		<p>
			<xsl:apply-templates select="tei:p/tei:stamp"/>
		</p>
		<p>
			<xsl:apply-templates select="tei:p/tei:address"/>
		</p>
	</xsl:template>

	<!-- TEMPLATE ZONE -->
	<xsl:template match="tei:zone">
		<xsl:variable name="cLar">
			<xsl:value-of select="substring-before(../tei:graphic/@width, 'px')"/>
		</xsl:variable>
		<xsl:variable name="cAlt">
			<xsl:value-of select="substring-before(../tei:graphic/@height, 'px')"/>
		</xsl:variable>
		<xsl:variable name="ulx">
			<xsl:value-of select="./@ulx"/>
		</xsl:variable>
		<xsl:variable name="uly">
			<xsl:value-of select="./@uly"/>
		</xsl:variable>
		<xsl:variable name="lrx">
			<xsl:value-of select="./@lrx"/>
		</xsl:variable>
		<xsl:variable name="lry">
			<xsl:value-of select="./@lry"/>
		</xsl:variable>
		<xsl:variable name="lar">
			<xsl:value-of select="$lrx - $ulx"/>
		</xsl:variable>
		<xsl:variable name="alt">
			<xsl:value-of select="$lry - $uly"/>
		</xsl:variable>
		<xsl:element name="div">
			<xsl:attribute name="id"><xsl:value-of select="@xml:id"/>_zona</xsl:attribute>
			<xsl:attribute name="onmouseover">mouse_sulla_cartolina('<xsl:value-of select="@xml:id"/>_zona')</xsl:attribute>
			<xsl:attribute name="onmouseout">mouse_via_cartolina('<xsl:value-of select="@xml:id"/>_zona')</xsl:attribute>
			<xsl:attribute name="style">
				position: absolute;
				left: <xsl:value-of select="$ulx div $cLar * 100"/>%;
				top: <xsl:value-of select="$uly div $cAlt * 100"/>%;
				width: <xsl:value-of select="$lar div $cLar * 100"/>%;
				height: <xsl:value-of select="$alt div $cAlt * 100"/>%;
			</xsl:attribute>
		</xsl:element>
	</xsl:template>

	<!-- TEMPLATE TESTO CARTOLINA -->
	<xsl:template match="tei:p | tei:opener | tei:closer | tei:stamp | tei:address">
		<xsl:variable name="lbTradotti">
			<xsl:apply-templates/>
		</xsl:variable>
		<xsl:copy-of select="$lbTradotti"/>
		<xsl:variable name="lastSpan"><![CDATA[</span>]]></xsl:variable>
		<xsl:value-of select="$lastSpan" disable-output-escaping="yes"/>
	</xsl:template>
	<xsl:template match="tei:s">
		<xsl:choose>
			<xsl:when test="count(following-sibling::tei:s)=0">
				<xsl:apply-templates/>
			</xsl:when>
			<xsl:when test="not(../tei:s[2][tei:lb])">
				<xsl:apply-templates/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates/>
				<xsl:variable name="lastSpan"><![CDATA[</span>]]></xsl:variable>
				<xsl:value-of select="$lastSpan" disable-output-escaping="yes"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="tei:name">
		<xsl:apply-templates/>
		<xsl:variable name="lastSpan"><![CDATA[</span>]]></xsl:variable>
		<xsl:value-of select="$lastSpan" disable-output-escaping="yes"/>
	</xsl:template>
	<xsl:template match="tei:stamp">
		<xsl:choose>
			<xsl:when test="./@type='postmark'">
				<xsl:apply-templates/>
				<xsl:variable name="lastSpan"><![CDATA[</span>]]></xsl:variable>
				<xsl:value-of select="$lastSpan" disable-output-escaping="yes"/>
			</xsl:when>
			<xsl:when test="./@type='postage'">
				<xsl:variable name="brSpan"><![CDATA[<br/><span]]> id="<xsl:value-of select="substring-after(./@facs, '#')"/>_riga" onmouseover="mouse_sul_testo('<xsl:value-of select="substring-after(./@facs, '#')"/>_riga')" onmouseout="mouse_via_testo('<xsl:value-of select="substring-after(./@facs, '#')"/>_riga')"<![CDATA[>]]></xsl:variable>
				<xsl:value-of select="$brSpan" disable-output-escaping="yes"/>
				<xsl:apply-templates/>
				<xsl:variable name="lastSpan"><![CDATA[</span>]]></xsl:variable>
				<xsl:value-of select="$lastSpan" disable-output-escaping="yes"/>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="tei:lb">
		<xsl:choose>
			<xsl:when test="count(preceding-sibling::tei:lb)=0">
				<xsl:variable name="brSpan"><![CDATA[<br/><span]]> id="<xsl:value-of select="substring-after(./@facs, '#')"/>_riga" onmouseover="mouse_sul_testo('<xsl:value-of select="substring-after(./@facs, '#')"/>_riga')" onmouseout="mouse_via_testo('<xsl:value-of select="substring-after(./@facs, '#')"/>_riga')"<![CDATA[>]]></xsl:variable>
				<xsl:value-of select="$brSpan" disable-output-escaping="yes"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:variable name="brSpan"><![CDATA[</span><br/><span]]> id="<xsl:value-of select="substring-after(./@facs, '#')"/>_riga" onmouseover="mouse_sul_testo('<xsl:value-of select="substring-after(./@facs, '#')"/>_riga')" onmouseout="mouse_via_testo('<xsl:value-of select="substring-after(./@facs, '#')"/>_riga')"<![CDATA[>]]></xsl:variable>
				<xsl:value-of select="$brSpan" disable-output-escaping="yes"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<!-- TEMPLATE GENERICI -->
	<xsl:template match="tei:choice">
		<span class="diplomatica"><xsl:apply-templates select="*[1]"/></span>
		<xsl:choose>
			<xsl:when test="./tei:expan">
				<span class="interpretativa" style="color: rgb(255, 255, 255); font-weight: normal;"><xsl:apply-templates select="./tei:expan"/></span>
			</xsl:when>
			<xsl:otherwise>
				<span class="interpretativa"><xsl:apply-templates select="*[2]"/></span>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="tei:ex">
		<span class="interpretativa"><xsl:apply-templates/></span>
	</xsl:template>
	<xsl:template match="tei:c">
		<span class="diplomatica"><xsl:apply-templates/></span>
		<span class="interpretativa"><xsl:value-of select="./@corresp"/></span>
	</xsl:template>
	<xsl:template match="tei:supplied">
		<span class="interpretativa"><xsl:apply-templates/></span>
	</xsl:template>
	<xsl:template match="tei:unclear">
		<xsl:choose>
			<xsl:when test="./@reason='illegible'"><span class="diplomatica">[illeggibile]</span></xsl:when>
			<xsl:when test="./@reason='parterased'"><span class="diplomatica">[parzialmente cancellato]</span></xsl:when>
		</xsl:choose>
		<span class="interpretativa"><xsl:apply-templates/></span>
	</xsl:template>
	<xsl:template match="tei:add">
		<sup class="diplomatica"><xsl:value-of select="."/></sup>
		<span class="interpretativa"><xsl:value-of select="."/></span>
	</xsl:template>
	<xsl:template match="tei:persName">
		<xsl:element name="a">
			<xsl:attribute name="href"><xsl:value-of select="./@ref"/></xsl:attribute>
			<xsl:value-of select="."/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="tei:placeName">
		<xsl:element name="a">
			<xsl:attribute name="href"><xsl:value-of select="./@ref"/></xsl:attribute>
			<xsl:value-of select="."/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="tei:forename">
		<xsl:variable name="space"><![CDATA[&#32;]]></xsl:variable>
		<xsl:value-of select="."/>
		<xsl:value-of select="$space" disable-output-escaping="yes"/>
	</xsl:template>
	<xsl:template match="tei:surname">
		<xsl:variable name="space"><![CDATA[&#32;]]></xsl:variable>
		<xsl:value-of select="$space" disable-output-escaping="yes"/>
		<xsl:value-of select="."/>
	</xsl:template>
	<xsl:template match="tei:addName">
		&#34;<xsl:value-of select="."/>&#34;
	</xsl:template>
</xsl:stylesheet>
