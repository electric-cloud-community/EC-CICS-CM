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

# Validation
#-----------------------------

# Uncomment bellow verifications when we start support CICSPlex SM
#if($params{'CSYSDEFModel'} and uc($params{'ResTableName'}) ne "CSYSDEF") {
#    print "ERROR: 'CSYSDEFModel' applies only to CSYSDEF objects.";
#    exit -1;
#}
#
#if(($params{'MonSpecInherit'} or $params{'RTASpecInherit'} or $params{'WLMSpecInherit'}) and uc($params{'ResTableName'}) ne "CSGLCGCS") {
#    print "ERROR: 'MonSpecInherit', 'RTASpecInherit', and 'WLMSpecInherit' apply only to CSGLCGCS.";
#    exit -1;
#}
#
#if($params{'LNKSWSCGParm'} and uc($params{'ResTableName'}) ne "LNKSWSCG") {
#    print "ERROR: 'LNKSWSCGParm' applies only to LNKSWSCG objects.";
#    exit -1;
#}

if((!$params{'ObjType'} and !$params{'ObjName'} and !$params{'ObjGroup'}) or !$params{'ObjectCriteria'}) {
    print "ERROR: Eeather 'ObjectCrireria' in xml or entry for 'ObjName', 'ObjGroup' and 'ObjType' should be filled.";
    exit -1;
}

# Procedure-specific Code
# -----------------------

# Build @ObjectCriteria

my @mParams = ('Command', 'ObjGroup', 'ObjType', 'ObjName', 'ObjDefVer', 'TContainer');
my @ObjectCriteria = createObjectCriteria(\@mParams, 1, "CmdAPost", %params);

my @data =
SOAP::Data->name($soapMethodName => \SOAP::Data->value(
    SOAP::Data->name('LocationCriteria' => \SOAP::Data->value(
        SoapData('LocationType')
    )),
    @ObjectCriteria,
    SOAP::Data->name('InputData' => \SOAP::Data->value(
        SoapData('ContainerName'),
        SoapData('ContainerType')
    ))
));

$[/myPlugin/project/ec_perl_code_block_2]
