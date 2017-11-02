$[/myPlugin/project/ec_perl_header]

# Procedure-specific Metadata
# ---------------------------

# Name of SOAP method to call
my $soapMethodName = 'Update';

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
            SoapData('ObjType')
        ));
} else {

    # Combine ObjName, ObjGroup, ObjType, and ObjectCriteria into @ObjectCriteria
    my $objectCriteria = $params{'ObjectCriteria'};
    @ObjectCriteria = SOAP::Data->name('ObjectCriteria' => \SOAP::Data->value(
            SoapData('ObjType'),
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
            SOAP::Data->name('ProcessParms' => \SOAP::Data->value(
                    SoapData('IntegrityToken'),
                    SoapData('CSYSDEFModel')
                )),
            SOAP::Data->name('InputData' => \SOAP::Data->value(
                    $inputData
                ))
        ));

$[/myPlugin/project/ec_perl_code_block_2]
