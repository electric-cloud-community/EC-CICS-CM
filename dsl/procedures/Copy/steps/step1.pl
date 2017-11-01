$[/myPlugin/project/ec_perl_header]

# Procedure-specific Metadata
# ---------------------------

# Name of SOAP method to call
my $soapMethodName = 'Copy';

# List of the names of optional paramters
my @optionalParams = (
);

$[/myPlugin/project/ec_perl_metadata]

$[/myPlugin/project/ec_perl_code_block_1]

# Procedure-specific Code
# -----------------------

# Build @ObjectCriteria
my @ObjectCriteria;
if (length $params{'ObjectCriteria'} == 0) {

    # No ObjectCriteria, so we only have one element, and can ommit the <ListCount> and <ListElement>
    @ObjectCriteria = SOAP::Data->name('ObjectCriteria' => \SOAP::Data->value(
        SOAP::Data->name('ListCount' => '1'),
            SOAP::Data->name('ListElement' => \SOAP::Data->value(
                SoapData('ObjName'),
                SoapData('ObjGroup'),
                SoapData('ObjType')
            ))
        ));
} else {

    # Combine ObjName, ObjGroup, ObjType, and ObjectCriteria into @ObjectCriteria
    my $objectCriteria = $params{'ObjectCriteria'};
    my @matches = $objectCriteria =~ m/<ListElement>/si;
    my $listCount = 1 + @matches;
    @ObjectCriteria = SOAP::Data->name('ObjectCriteria' => \SOAP::Data->value(
            SOAP::Data->name('ListCount' => $listCount),
            SOAP::Data->name('ListElement' => \SOAP::Data->value(
                    SoapData('ObjName'),
                    SoapData('ObjGroup'),
                    SoapData('ObjType')
                )),
            SOAP::Data->type('xml' => $objectCriteria)
        ));
}

my @data =
    SOAP::Data->name($soapMethodName => \SOAP::Data->value(
            SOAP::Data->name('LocationCriteria' => \SOAP::Data->value(
                    SoapData('LocationName'),
                    SoapData('LocationType')
                )),
            SOAP::Data->name('ObjectCriteria' => @ObjectCriteria),
            SOAP::Data->name('InputData' => \SOAP::Data->value(
                    SoapData('TargetLocationName'),
                    SoapData('TargetLocationType'),
                    $[/javascript (('' + myParent.TargetGroup).length == 0) ? "" : "SoapData('TargetGroup')"]
            )),
            SOAP::Data->name('ProcessParms' => \SOAP::Data->value(
                    SoapData('Replace')
            ))

        ));

$[/myPlugin/project/ec_perl_code_block_2]
