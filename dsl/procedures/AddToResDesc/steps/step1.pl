$[/myPlugin/project/ec_perl_header]

# Procedure-specific Metadata
# ---------------------------

# Name of SOAP method to call
my $soapMethodName = 'Add';

# List of the names of optional paramters
my @optionalParams = (
    'ObjectCriteria'
);

$[/myPlugin/project/ec_perl_metadata]

$[/myPlugin/project/ec_perl_code_block_1]

# Procedure-specific Code
# -----------------------

# Build @ObjectCriteria
my @mParams = ('ObjName', 'ObjType');
my @ObjectCriteria = createObjectCriteria(\@mParams, 0, "GrpA", \%params);

my @data =
SOAP::Data->name($soapMethodName => \SOAP::Data->value(
    SOAP::Data->name('LocationCriteria' => \SOAP::Data->value(
        SoapData('LocationName'),
        SoapData('LocationType')
    )),
    @ObjectCriteria,
    SOAP::Data->name('InputData' => \SOAP::Data->value(
        SoapData('ContainerName'),
        SoapData('ContainerType')
    ))
));

$[/myPlugin/project/ec_perl_code_block_2]
