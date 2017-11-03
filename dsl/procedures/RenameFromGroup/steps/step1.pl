$[/myPlugin/project/ec_perl_header]

# Procedure-specific Metadata
# ---------------------------

# Name of SOAP method to call
my $soapMethodName = 'Remove';

# List of the names of optional paramters
my @optionalParams = (
);

$[/myPlugin/project/ec_perl_metadata]

$[/myPlugin/project/ec_perl_code_block_1]


# Procedure-specific Code
# -----------------------

# Build @ObjectCriteria

my @data =
SOAP::Data->name($soapMethodName => \SOAP::Data->value(
    SOAP::Data->name('LocationCriteria' => \SOAP::Data->value(
        SoapData('LocationName'),
        SoapData('LocationType')
    )),
    SOAP::Data->name('ObjectCriteria' => \SOAP::Data->value(
        SoapData('ObjName'),
        SoapData('ObjType'),
    )),
    SOAP::Data->name('InputData' => \SOAP::Data->value(
        SoapData('SourceName'),
        SoapData('SourceType'),
        SoapData('TargetGroup')
    )),
    SOAP::Data->name('ProcessParms' => \SOAP::Data->value(
        SoapData('Replace')
    ))
));

$[/myPlugin/project/ec_perl_code_block_2]
