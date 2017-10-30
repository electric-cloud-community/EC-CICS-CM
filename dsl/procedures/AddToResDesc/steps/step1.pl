$[/myPlugin/project/ec_perl_header]

# Procedure-specific Metadata
# ---------------------------

# Name of SOAP method to call
my $soapMethodName = 'Add';

# List of the names of optional paramters
my @optionalParams = (

);

my @mandatoryParams = (
    'ContainerName',
    'ContainerType',
);

$[/myPlugin/project/ec_perl_metadata]

$[/myPlugin/project/ec_perl_code_block_1]

# Procedure-specific Code
# -----------------------

my @paramsForRequest;
for my $p (@optionalParams, @mandatoryParams) {
    if (defined $params{$p}) {
        push @paramsForRequest, SoapData($p);
    }
}

my @validCriteriaKeys = ('ObjType', 'ObjName');

my @result = makeAddObjectCriteria($params{'ObjectCriteria'}, 'GrpA', @validCriteriaKeys);

my @data =
SOAP::Data->name($soapMethodName => \SOAP::Data->value(
    SOAP::Data->name('LocationCriteria' => \SOAP::Data->value(
            SoapData('LocationName'),
            SoapData('LocationType')
    )) ,
    SOAP::Data->name('ObjectCriteria' => \SOAP::Data->value(
        @result
    )),
    SOAP::Data->name('InputData' => \SOAP::Data->value(
        @paramsForRequest
    ))
));

$[/myPlugin/project/ec_perl_code_block_2]
