$[/myPlugin/project/ec_perl_header]

# Procedure-specific Metadata
# ---------------------------

# Name of SOAP method to call
my $soapMethodName = 'Create';

# List of the names of optional paramters
my @optionalParams = (
    'CSYSDEFModel',
    'MonSpecInherit',
    'RTASpecInherit',
    'WLMSpecInherit',
    'LNKSWSCGParm',

);
# TODO Get rid of this -- we shouldn't need it, we already have a list of all parameters and a list of which are optional
my @mandatoryParams = (
    'LocationName',
    'ObjectData',

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

my $data =
SOAP::Data->name('CCV530' => \SOAP::Data->value(
    SOAP::Data->name('LocationCriteria' => \SOAP::Data->value(
        SOAP::Data->name('LocationName' => $params{'LocationName'}),
        SOAP::Data->name('LocationType' => $params{'LocationType'})
    )) ,
    SOAP::Data->name('ObjectCriteria' => \SOAP::Data->value(
        SOAP::Data->name('ObjName' => $params{'ObjName'}),
        SOAP::Data->name('ObjGroup' => $params{'ObjGroup'}),
        SOAP::Data->name('ObjType' => $params{'ObjType'}),
  )) ,
  SOAP::Data->name('InputData' => \SOAP::Data->value(
        @paramsForRequest
        #  SoapData('ObjectData') //TODO decide how to get specific values for necessary ObjectData.
    ))
));

$[/myPlugin/project/ec_perl_code_block_2]
