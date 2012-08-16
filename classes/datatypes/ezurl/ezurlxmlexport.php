<?php
/**
 * File containing the eZURLXMLExport class
 *
 * @copyright Copyright (C) 1999-2012 eZ Systems AS. All rights reserved.
 * @license http://ez.no/licenses/gnu_gpl GNU GPLv2
 * @package ezxmlexport
 *
 */

/*
 * Complex type for this datatype
 * No complex type for this datatype
 */

class eZURLXMLExport extends eZXMLExportDatatype
{
    protected function defaultValue()
    {
        return false;
    }

    protected function toXMLSchema()
    {
        return '<xs:complexType>
                    <xs:simpleContent>
                        <xs:extension base="ezstring"/>
                    </xs:simpleContent>
                </xs:complexType>';
    }

    protected function toXML()
    {
    		$xmlExportIni = eZINI::instance( 'ezxmlexport.ini' );
    		$output = $this->contentObjectAttribute->content();
        
        if ( $xmlExportIni->variable( 'ExportSettings', 'UseCDATA' ) === 'enabled' )
            return "<![CDATA[\n$output]]>\n";
        
        return "\n$output\n";
    }
}
?>