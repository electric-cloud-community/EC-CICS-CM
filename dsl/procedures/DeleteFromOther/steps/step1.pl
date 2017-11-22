$[/myPlugin/project/ec_perl_header]

# Procedure-specific Metadata
# ---------------------------

# Name of SOAP method to call
my $soapMethodName = 'Delete';

# List of the names of optional paramters
my @optionalParams = (
    'ObjGroup',
    'ObjectData',
    'IntegrityToken',
    'MonSpecInherit',
    'RTASpecInherit',
    'WLMSpecInherit',
    'LNKSWSCGParm',
);

$[/myPlugin/project/ec_perl_metadata]

$[/myPlugin/project/ec_perl_code_block_1]

# Procedure-specific Code
# -----------------------

# Validation #### TODO Check this

if(length($params{'CSYSDEFModel'}) and uc($params{'ResTableName'}) ne "CSYSDEF") {
    print "ERROR: 'CSYSDEF Model' applies only to CSYSDEF objects.";
    exit -1;
}

if(((length($params{'MonSpecInherit'}) or length($params{'RTASpecInherit'}) or length($params{'WLMSpecInherit'}))) and uc($params{'ResTableName'}) ne "CSGLCGCS") {
    print "ERROR: 'Mon Spec Inherit', 'RTA Spec Inherit', and 'WLM Spec Inherit' apply only to CSGLCGCS objects.";
    exit -1;
}
if(length($params{'LNKSWSCGParm'}) and uc($params{'ResTableName'}) ne "LNKSWSCG") {
    print "ERROR: 'LNKSWSCG Parameter' applies only to LNKSWSCG objects.";
    exit -1;
}
# Handle optional parametrs
my @paramsForRequest = (
    'CSYSDEFModel', #### TODO Confirm these
    'MonSpecInherit',
    'RTASpecInherit',
    'WLMSpecInherit',
    'LNKSWSCGParm',
);
my @paramsForRequestResult;
for my $param (@paramsForRequest) {
    if (length($params{$param}) > 0) {
        push @paramsForRequestResult, SoapData($param);
    }
}
my @processParms;
if (scalar(@paramsForRequestResult) > 0) {
    @processParms = SOAP::Data->name('ProcessParms' => \SOAP::Data->value(@paramsForRequest));
}

my @data =
    SOAP::Data->name($soapMethodName => \SOAP::Data->value(
        SOAP::Data->name('LocationCriteria' => \SOAP::Data->value(
            SoapData('LocationName'),
            SoapData('LocationType')
        )),
        SOAP::Data->name('ObjectCriteria' => \SOAP::Data->value(
            SoapData('ObjType'),
            SoapData('ObjName'),
            SoapDataOptional('ObjGroup'),
            SoapDataOptional('ObjDefVer')
        )), #### TODO Handle IntegrityToken
        @processParms
    ));

$[/myPlugin/project/ec_perl_code_block_2]
