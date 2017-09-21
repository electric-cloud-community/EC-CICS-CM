$[/myPlugin/project/ec_perl_header]

# Procedure-specific Metadata
# ---------------------------

# Name of SOAP method to call
my $soapMethodName = 'Install';

# List of the names of optional paramters
my @optionalParams = (
    'Quiesce',
    'Discard',
    'Force',
    'TargetScope',
    'ResGroupObjectType',
    'CONNDEF_RefAssign',
    'FILEDEF_RelatedScope',
    'FILEDEF_Usage',
    'PROGDEF_RelatedScope',
    'PROGDEF_Usage',
    'PROGDEF_Mode',
    'TDQDEF_RelatedScope',
    'TDQDEF_Usage',
    'TDQDEF_Mode',
    'TRANDEF_RelatedScope',
    'TRANDEF_Usage',
    'TRANDEF_Mode',

);
my @mandatoryParams = (
    'CPID',
    'Scheme',
    'QualificationData',

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
