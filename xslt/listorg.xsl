<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    version="2.0" exclude-result-prefixes="xsl tei xs">
    <xsl:output encoding="UTF-8" media-type="text/html" method="html" version="5.0" indent="yes" omit-xml-declaration="yes"/>
    
    <xsl:import href="./partials/html_navbar.xsl"/>
    <xsl:import href="./partials/html_head.xsl"/>
    <xsl:import href="./partials/html_footer.xsl"/>
    <xsl:import href="partials/tabulator_dl_buttons.xsl"/>
    <xsl:import href="partials/tabulator_js.xsl"/>
    
    
    <xsl:template match="/">
        <xsl:variable name="doc_title">
            <xsl:value-of select=".//tei:titleStmt/tei:title[1]/text()"/>
        </xsl:variable>
        <html class="h-100">
            
            <head>
                <xsl:call-template name="html_head">
                    <xsl:with-param name="html_title" select="$doc_title"></xsl:with-param>
                </xsl:call-template>
            </head>
            
            <body class="d-flex flex-column h-100">
                <xsl:call-template name="nav_bar"/>
                <main class="flex-shrink-0 flex-grow-1">
                    <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb"
                        class="ps-5 p-3">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item">
                                <a href="index.html">
                                    <xsl:value-of select="$project_short_title"/>
                                </a>
                            </li>
                            <li class="breadcrumb-item active" aria-current="page">Alle
                                Institutionen</li>
                        </ol>
                    </nav>
                    <div class="container">
                        
                        <h1 class="display-5 text-center">
                            <xsl:value-of select="$doc_title"/>
                        </h1>
                        <div class="text-center p-1">
                            <span id="counter1"/> von <span id="counter2"/>Institutionen
                        </div>
                        
                        <table id="myTable">
                            <thead>
                                <tr>
                                    <th scope="col" tabulator-headerFilter="input"
                                        tabulator-formatter="html" tabulator-download="false"
                                        tabulator-minWidth="350">Name</th>
                                    <th scope="col" tabulator-headerFilter="input"
                                        tabulator-visible="false" tabulator-download="true"
                                        >name_</th>
                                    <th scope="col" tabulator-headerFilter="input">Nennungen</th>
                                    <th scope="col" tabulator-headerFilter="input"
                                        tabulator-maxWidth="170">ID</th>
                                </tr>
                            </thead>
                            <tbody>
                                <xsl:for-each select=".//tei:org[@xml:id]">
                                    <xsl:sort select="normalize-space(./tei:orgName/text())"/>
                                    <xsl:variable name="id">
                                        <xsl:value-of select="data(@xml:id)"/>
                                    </xsl:variable>
                                    <tr>
                                        <td>
                                            <a>
                                                <xsl:attribute name="href">
                                                    <xsl:value-of select="concat($id, '.html')"/>
                                                </xsl:attribute>
                                                <xsl:value-of select="normalize-space(./tei:orgName/text())"/>
                                            </a>
                                        </td>
                                        <td>
                                            <xsl:value-of select="./tei:orgName/text()"/>
                                        </td>
                                        <td>
                                            <xsl:value-of select="count(.//tei:ptr)"/>
                                        </td>

                                        <td>
                                            <xsl:value-of select="$id"/>
                                        </td>
                                    </tr>
                                </xsl:for-each>
                            </tbody>
                        </table>
                        <xsl:call-template name="tabulator_dl_buttons"/>
                    </div>
                </main>
                <xsl:call-template name="html_footer"/>
                <xsl:call-template name="tabulator_js"/>
            </body>
        </html>
        
        
        <xsl:for-each select=".//tei:org[@xml:id]">
            <xsl:variable name="filename" select="concat(./@xml:id, '.html')"/>
            <xsl:variable name="doc_title" select="normalize-space(string-join(./tei:orgName[1]//text()))"></xsl:variable>
            <xsl:result-document href="{$filename}">
                <html class="h-100">
                    <head>
                        <xsl:call-template name="html_head">
                            <xsl:with-param name="html_title" select="$doc_title"></xsl:with-param>
                        </xsl:call-template>
                    </head>
                    
                    <body class="d-flex flex-column h-100">
                        <xsl:call-template name="nav_bar"/>
                        <main class="flex-shrink-0 flex-grow-1">
                            <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb"
                                class="ps-5 p-3">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item">
                                        <a href="index.html">
                                            <xsl:value-of select="$project_short_title"/>
                                        </a>
                                    </li>
                                    <li class="breadcrumb-item"><a href="listorg.html">Alle Institutionen</a></li>
                                </ol>
                            </nav>
                            <div class="container">
                                <h1 class="display-5 text-center">
                                    <xsl:value-of select="$doc_title"/>
                                </h1>
                                <h2>erwähnt in</h2>
                                <ul>
                                    <xsl:for-each select=".//tei:ptr">
                                        <li>
                                            <a href="{replace(@target, '.xml', '.html')}"><xsl:value-of select="@n"/></a>
                                        </li>
                                    </xsl:for-each>
                                </ul>  
                            </div>
                        </main>
                        <xsl:call-template name="html_footer"/>
                    </body>
                </html>
            </xsl:result-document>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>