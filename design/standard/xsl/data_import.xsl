<?xml version="1.0" encoding="UTF-8"?>
 <!--
    XSL stylesheet to transform 'ezxmlexport' eZ-extension XML into 'data_import' eZ-extension XML
    Russell Michell April 2010 r DOT michell AT gns DOT cri DOT nz
    - updated by Geoff Bentley 2012
 -->
 <xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
 <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" xml:space="preserve" cdata-section-elements="field" />
    <xsl:template match="/ezpublish">
    <all>
        <xsl:for-each select="objects">
        <xsl:sort select="./child::node()/show_children" data-type="number" order="descending" />
        <entry>
            <xsl:for-each select="./*">
            <!-- "Dynamically" add attributes to the <entry> element -->
                <xsl:attribute name="type">
                    <xsl:value-of select="name(.)" />
                </xsl:attribute>
                <xsl:attribute name="id">
                    <xsl:value-of select="@contentobject_id" />
                </xsl:attribute>
                <xsl:attribute name="language">
                    <xsl:value-of select="@lang" />
                </xsl:attribute>
                <xsl:attribute name="parent_id">
                    <xsl:value-of select="@parent_id" />
                </xsl:attribute>
                <xsl:attribute name="remote_id">
                    <xsl:value-of select="@remote_id" />
                </xsl:attribute>
                <xsl:for-each select="./*[not(self::object_metadata)]">
		                <field>
						            <xsl:attribute name="name">
				                    <xsl:value-of select="local-name()" />
				                </xsl:attribute>
		                    <xsl:value-of disable-output-escaping="no" select="current()" />
		                </field>
                </xsl:for-each>
            </xsl:for-each>
        </entry>
        </xsl:for-each>
    </all>
    </xsl:template>
 </xsl:stylesheet>