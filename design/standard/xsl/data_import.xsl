<?xml version="1.0" encoding="UTF-8"?>
 <!--
    XSL stylesheet to transform 'ezxmlexport' eZ-extension XML into 'data_import' eZ-extension XML
    Russell Michell April 2010 r DOT michell AT gns DOT cri DOT nz
    - updated by Geoff Bentley 2012
 -->
 <xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
 <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" xml:space="preserve" cdata-section-elements="field" />
    
    <!--  Set up grouping for Object Relations -->
    <xsl:key name="groupName" match="object_id" use="concat(../../@remote_id,'+',name(..))"/>

		<!-- Set upper hierachy using Identity rule  -->    
    <xsl:template match="node()|@*">
     <xsl:copy>
       <xsl:apply-templates select="node()|@*"/>
     </xsl:copy>
    </xsl:template>

    <xsl:template match="/ezpublish">
    <all>
        <xsl:for-each select="objects">
        <!-- Create objects with children first -->
        <xsl:sort select="./child::node()/show_children" data-type="number" order="descending" />
            <xsl:apply-templates select="child::node()" />
        </xsl:for-each>
    </all>
    </xsl:template>
    
    <xsl:template match="objects/*">
        <entry>
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
                
								<xsl:apply-templates select="./*"/>
        </entry>
    </xsl:template>
    
    <xsl:template match="object_metadata" />
    
    <!-- Create all fields except Object Relations -->
    <xsl:template match="objects/*/*[not( self::object_metadata|object_id )]">
        <field>
          <xsl:attribute name="name">
              <xsl:value-of select="local-name()" />
          </xsl:attribute>
          <xsl:value-of disable-output-escaping="no" select="current()" />
        </field>
    </xsl:template>
    
    <!-- Remove unwanted Object Relations nodes -->
    <xsl:template match="*[object_id]"/>
    
    <!-- and merge Object Relations data into a single node (per object/field) -->
    <xsl:template priority="2" match=
		 "*[object_id and 
		 		generate-id(object_id)=
		 		generate-id(key('groupName',concat(../@remote_id,'+',name()))[1])
		 		]">
		 		<field>
					  <xsl:attribute name="name">
				        <xsl:value-of select="local-name()" />
				    </xsl:attribute>
				     <xsl:for-each select="key('groupName',concat(../@remote_id,'+',name()))">
				      	<xsl:if test="not(position()=1)">-</xsl:if>
				      	<xsl:value-of select="."/>
				     </xsl:for-each>
		   </field>
		 </xsl:template>
		 
 </xsl:stylesheet>