$[/myPlugin/project/ec_perl_header]

# Procedure-specific Metadata
# ---------------------------

# Name of SOAP method to call
my $soapMethodName = 'List';

# List of the names of optional paramters
my @optionalParams = (

);
#### TODO Get rid of this -- we shouldn't need it, we already have a list of all parameters and a list of which are optional
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
SOAP::Data->name('LocationCriteria' => \SOAP::Data->value(
    SOAP::Data->name('LocationType' => $params{'LocationType'})
)) .
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
  )) .
SOAP::Data->name('InputData' => \SOAP::Data->value(
    @paramsForRequest
));

$[/myPlugin/project/ec_perl_code_block_2]