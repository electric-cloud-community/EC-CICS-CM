$[/myPlugin/project/ec_perl_header]

# Procedure-specific Metadata
# ---------------------------

# Name of SOAP method to call
my $soapMethodName = 'List';

# List of the names of optional paramters
my @optionalParams = (
    'ObjGroup', 'ObjDefVer', 'RestrictionCriteria'
);

$[/myPlugin/project/ec_perl_metadata]

$[/myPlugin/project/ec_perl_code_block_1]

# Procedure-specific Code
# -----------------------

#### TODO Split and parse restrictionCriteria

my @paramsForRequest;
for my $name (@names) {
    if (defined $params{$name}) {
        push @paramsForRequest, SoapData($name);
    }
}

my $data =
SOAP::Data->name('CCV510' => \SOAP::Data->value(
    SOAP::Data->name('LocationCriteria' => \SOAP::Data->value(
        SoapData('LocationName'),
        SoapData('LocationType')
    )),
    SOAP::Data->name('ObjectCriteria' => \SOAP::Data->value(
        SoapData('CConfig'),
        SOAP::Data->name('ListCount' => 1),
        SOAP::Data->name('ListElement' => \SOAP::Data->value(
            SOAP::Data->name('DefA' => \SOAP::Data->value(
                SoapData('ObjGroup'),
                SoapData('ObjType'),
                SoapData('ObjName')
            ))
        ))
    )),
    SOAP::Data->name('InputData' => \SOAP::Data->value( #### TODO Why is this here?
        @paramsForRequest
    ))
));

$[/myPlugin/project/ec_perl_code_block_2]
