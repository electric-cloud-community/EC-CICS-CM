$[/myPlugin/project/ec_perl_header]

# Procedure-specific Metadata
# ---------------------------

# Name of SOAP method to call
my $soapMethodName = 'Add';

# List of the names of optional paramters
my @mandatoryParams = (
    'ContainerName',
    'ContainerType'
);

my @optionalParams = ();

$[/myPlugin/project/ec_perl_metadata]

$[/myPlugin/project/ec_perl_code_block_1]

# Procedure-specific Code
# -----------------------

my @ObjectCriteria;
if (length $params{'ObjectCriteria'} == 0) {

    # No ObjectCriteria, so we only have one element, and can ommit the <ListCount> and <ListElement>
    @ObjectCriteria = SOAP::Data->name('ObjectCriteria' => \SOAP::Data->value(
        SOAP::Data->name('DefA' => \SOAP::Data->value(
            SoapData('ObjGroup'),
            SoapData('ObjName'),
            SoapData('ObjType'),
            SoapData('ObjDefVer')
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
                    SOAP::Data->name('DefA' => \SOAP::Data->value(
                            SoapData('ObjGroup'),
                            SoapData('ObjName'),
                            SoapData('ObjType'),
                            SoapData('ObjDefVer')
                        ))
                )),
            SOAP::Data->type('xml' => $objectCriteria)
        ));
}

my @paramsForRequest;
for my $p (@mandatoryParams) {
    if (defined $params{$p}) {
        push @paramsForRequest, SoapData($p);
    }
}

my @data =
SOAP::Data->name($soapMethodName => \SOAP::Data->value(
    SOAP::Data->name('LocationCriteria' => \SOAP::Data->value(
            SoapData('LocationName'),
            SoapData('LocationType')
    )) ,
    SOAP::Data->name('ObjectCriteria' => @ObjectCriteria),
    SOAP::Data->name('InputData' => \SOAP::Data->value(
        @paramsForRequest
    ))
));

$[/myPlugin/project/ec_perl_code_block_2]
