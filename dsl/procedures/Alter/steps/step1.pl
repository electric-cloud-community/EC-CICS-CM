$[/myPlugin/project/ec_perl_header]

# Procedure-specific Metadata
# ---------------------------

# Name of SOAP method to call
my $soapMethodName = 'Alter';

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
            SoapData('ObjName'),
            SoapData('ObjGroup'),
            SoapData('ObjType'),
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

my $inputData;
my $dataObjectType = $params{'DataObjType'};
if($dataObjectType) {
    $inputData = SOAP::Data->name($dataObjectType => \SOAP::Data->value(
                    SOAP::Data->name('ObjectData' => \SOAP::Data->value(
                            SOAP::Data->type('xml' => $params{'ObjectData'})
                    )),
                ));
}
else {
    $inputData = SOAP::Data->name('ObjectData' => \SOAP::Data->value(
            SOAP::Data->type('xml' => $params{'ObjectData'})
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
                $inputData
        ))
    ));

$[/myPlugin/project/ec_perl_code_block_2]
