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

my @mParams = ('ObjName', 'ObjGroup', 'ObjType');
my @ObjectCriteria = createObjectCriteria(\@mParams, 1, "", %params);

# Combine ObjName, ObjGroup, ObjType, and ObjectCriteria into @ObjectCriteria
my $inputData = $params{'ObjectData'};
my @matchesTarget = $inputData =~ m/<TargetElement>/si;
my $targetCount = 1 + @matchesTarget;
my @InputData = SOAP::Data->name('ObjectCriteria' => \SOAP::Data->value(
        SOAP::Data->name('TargetCount' => $targetCount),
        SOAP::Data->name('TargetElement' => \SOAP::Data->value(
                SoapData('TargetName'),
                SoapData('TargetGroup')
            )),
        SOAP::Data->type('xml' => $inputData)
    ));


my @data =
SOAP::Data->name($soapMethodName => \SOAP::Data->value(
    SOAP::Data->name('LocationCriteria' => \SOAP::Data->value(
        SoapData('LocationName'),
        SoapData('LocationType')
    )),
    SOAP::Data->name('ObjectCriteria' => \SOAP::Data->value(
        SOAP::Data->name('ObjectCriteria' => @ObjectCriteria),
    )),
    SOAP::Data->name('InputData' => \SOAP::Data->value(
        SOAP::Data->name('InputData' => @InputData),
    )),
    SOAP::Data->name('ProcessParms' => \SOAP::Data->value(
        SoapData('Replace')
    ))
));

$[/myPlugin/project/ec_perl_code_block_2]
