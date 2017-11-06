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

my @paramsForRequest;
for my $p (@mandatoryParams) {
    if (defined $params{$p}) {
        push @paramsForRequest, SoapData($p);
    }
}

my @mParams = ('ObjGroup', 'ObjName', 'ObjType', 'ObjDefVer');

my @ObjectCriteria = createObjectCriteria(\@mParams, 0, "DefA", %params);

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
