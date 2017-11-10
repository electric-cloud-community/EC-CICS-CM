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

#### TODO Uncomment below verifications 
#if($length(params{'CSYSDEFModel'}) and uc($params{'ResTableName'}) ne "CSYSDEF") {
#    print "ERROR: 'CSYSDEF Model' applies only to CSYSDEF objects.";
#    exit -1;
#}
#
#if((length($params{'MonSpecInherit'}) or length($params{'RTASpecInherit'}) or length($params{'WLMSpecInherit'})) and uc($params{'ResTableName'}) ne "CSGLCGCS") {
#    print "ERROR: 'Mon Spec Inherit', 'RTA Spec Inherit', and 'WLM Spec Inherit' apply only to CSGLCGCS objects.";
#    exit -1;
#}
#
#if(length($params{'LNKSWSCGParm'}) and uc($params{'ResTableName'}) ne "LNKSWSCG") {
#    print "ERROR: 'LNKSWSCG Parmeter' applies only to LNKSWSCG objects.";
#    exit -1;
#}

# Procedure-specific Code
# -----------------------

# Build @ObjectCriteria

my @mParams = ('Command', 'ObjGroup', 'ObjType', 'ObjName', 'ObjDefVer', 'TContainer');
my @ObjectCriteria = createObjectCriteria(\@mParams, 1, "CmdAPost", \%params);

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
