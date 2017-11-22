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

my @ObjectData = createObjectData($params{'ObjectData'}, 1); # 1 to allow XML values

my $inputData;
my $dataObjectType = $params{'DataObjType'};
if($dataObjectType) {
    $inputData = SOAP::Data->name($dataObjectType => \SOAP::Data->value(
        SOAP::Data->name('ObjectData' => \SOAP::Data->value(
            @ObjectData
        )),
    ));
}
else {
    $inputData = SOAP::Data->name('ObjectData' => \SOAP::Data->value(
        @ObjectData
    ));
}

my @processParms;
if($params{'CSYSDEFModel'} or $params{'IntegrityToken'}) {
    SOAP::Data->name('ProcessParms' => \SOAP::Data->value(
        $[/javascript (('' + myParent.IntegrityToken).length == 0) ? "" :
            "        SoapData('IntegrityToken'),  # Optional parameter "
        ]
        $[/javascript (('' + myParent.CSYSDEFModel).length == 0) ? "" :
            "        SoapData('CSYSDEFModel'),  # Optional parameter "
        ]
    ));
}

my @data =
    SOAP::Data->name($soapMethodName => \SOAP::Data->value(
        SOAP::Data->name('LocationCriteria' => \SOAP::Data->value(
            SoapData('LocationName'),
            SoapData('LocationType')
        )),
        SOAP::Data->name('ObjectCriteria' => @ObjectCriteria),
        @processParms,
        SOAP::Data->name('InputData' => \SOAP::Data->value(
            $inputData
        ))
    ));

$[/myPlugin/project/ec_perl_code_block_2]
