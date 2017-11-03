$[/myPlugin/project/ec_perl_header]

# Procedure-specific Metadata
# ---------------------------

# Name of SOAP method to call
my $soapMethodName = 'Add'; 

# List of the names of optional paramters
my @optionalParams = ('ObjectCriteria');

$[/myPlugin/project/ec_perl_metadata]

$[/myPlugin/project/ec_perl_code_block_1]

# Procedure-specific Code
# -----------------------

# Build @ObjectCriteria
my @ObjectCriteria;
if ($params{'ObjectCriteria'}.length == 0) {
    
    # No ObjectCriteria, so we only have one element, and can ommit the <ListCount> and <ListElement>
    @ObjectCriteria = SOAP::Data->name('ObjectCriteria' => \SOAP::Data->value(
        SoapData('CConfig'),
        SOAP::Data->name('KeyA' => \SOAP::Data->value(
            SoapData('ObjGroup'),
            SoapData('ObjType'),
            SoapData('ObjName'),
        ))
    ));
} else {

    # Combine ObjName, ObjGroup, ObjType, and ObjectCriteria into @ObjectCriteria
    my $objectCriteria = $params{'ObjectCriteria'};
    #### TODO Confirm $objectCriteria is a valid XML fragment matching the expected schema for this method
    my @matches = $objectCriteria =~ m/<ListElement>/si;
    my $listCount = 1 + @matches;
    @ObjectCriteria = SOAP::Data->name('ObjectCriteria' => \SOAP::Data->value(
        SoapData('CConfig'),
        SOAP::Data->name('ListCount' => $listCount),
        SOAP::Data->name('KeyA' => \SOAP::Data->value(
            SoapData('ObjGroup'),
            SoapData('ObjType'),
            SoapData('ObjName'),
        )),
        SOAP::Data->type('xml' => $objectCriteria)
    ));    
}

my @data  =
SOAP::Data->name($soapMethodName => \SOAP::Data->value(
    SOAP::Data->name('LocationCriteria' => \SOAP::Data->value(
            SoapData('LocationType')
    )),
    SOAP::Data->name('ObjectCriteria' => @ObjectCriteria),
    SOAP::Data->name('InputData' => \SOAP::Data->value(
        SoapData('ContainerName'),
        SoapData('ContainerType')
    ))
));

$[/myPlugin/project/ec_perl_code_block_2]
