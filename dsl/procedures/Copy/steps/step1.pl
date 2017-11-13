$[/myPlugin/project/ec_perl_header]

# Procedure-specific Metadata
# ---------------------------

# Name of SOAP method to call
my $soapMethodName = 'Copy';

# List of the names of optional paramters
my @optionalParams = (
);

$[/myPlugin/project/ec_perl_metadata]

$[/myPlugin/project/ec_perl_code_block_1]

# Procedure-specific Code
# -----------------------

# Build @ObjectCriteria
my @mParams = ('ObjName', 'ObjGroup', 'ObjType');

my @ObjectCriteria = createObjectCriteria(\@mParams, 0, "", \%params);

my @data =
    SOAP::Data->name($soapMethodName => \SOAP::Data->value(
        SOAP::Data->name('LocationCriteria' => \SOAP::Data->value(
            SoapData('LocationName'),
            SoapData('LocationType')
        )),
        SOAP::Data->name('ObjectCriteria' => @ObjectCriteria),
        SOAP::Data->name('InputData' => \SOAP::Data->value(
            SoapData('TargetLocationName'),
            SoapData('TargetLocationType'),
$[/javascript (('' + myParent.TargetGroup).length == 0) ? "" :
"            SoapData('TargetGroup') "
]
        )),
        SOAP::Data->name('ProcessParms' => \SOAP::Data->value(
            SoapData('Replace')
        ))
    ));

$[/myPlugin/project/ec_perl_code_block_2]
