$[/myPlugin/project/ec_perl_header]

# Procedure-specific Metadata
# ---------------------------

# Name of SOAP method to call
my $soapMethodName = 'Delete';

# List of the names of optional paramters
my @optionalParams = (
    'IntegrityToken',
    'MonSpecInherit',
    'RTASpecInherit',
    'WLMSpecInherit',
    'LNKSWSCGParm',
);

$[/myPlugin/project/ec_perl_metadata]

$[/myPlugin/project/ec_perl_code_block_1]

# Procedure-specific Code
# -----------------------

my @ObjectCriteria;
if (length $params{'ObjectCriteria'} == 0) {

    # No ObjectCriteria, so we only have one element, and can ommit the <ListCount> and <ListElement>
    @ObjectCriteria = SOAP::Data->name('ObjectCriteria' => \SOAP::Data->value(
            SoapData('ObjName'),
            SoapData('ObjGroup'),
            SoapData('ObjType'),
            SoapData('ObjDefVer')
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
                    SoapData('ObjType'),
                    SoapData('ObjDefVer')
                )),
            SOAP::Data->type('xml' => $objectCriteria)
        ));
}

# Handle optional parametrs
my @paramsForRequest;
for my $p (@optionalParams) {
    if ($params{$p} ne "") {
        push @paramsForRequest, SoapData($p);
    }
}
my @processParms;
if(scalar(@paramsForRequest) > 0) {
    @processParms = SOAP::Data->name('ProcessParms' => \SOAP::Data->value(@paramsForRequest));
}

my @data =
    SOAP::Data->name($soapMethodName => \SOAP::Data->value(
            SOAP::Data->name('LocationCriteria' => \SOAP::Data->value(
                    SoapData('LocationName'),
                    SoapData('LocationType')
                )),
            SOAP::Data->name('ObjectCriteria' => @ObjectCriteria),
            @processParms

    ));

$[/myPlugin/project/ec_perl_code_block_2]
