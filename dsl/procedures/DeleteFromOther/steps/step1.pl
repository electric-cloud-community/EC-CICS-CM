$[/myPlugin/project/ec_perl_header]

# Procedure-specific Metadata
# ---------------------------

# Name of SOAP method to call
my $soapMethodName = 'Delete';

# List of the names of optional paramters
my @optionalParams = (
    'ObjGroup',
    'ObjDefVer',
    'ObjectData',
    'IntegrityToken',
    'MONSpecInherit',
    'RTASpecInherit',
    'WLMSpecInherit',
    'LNKSWSCGParm',
);

$[/myPlugin/project/ec_perl_metadata]

$[/myPlugin/project/ec_perl_code_block_1]

# Procedure-specific Code
# -----------------------

# Validation

# Validate ObjectCriteria isn't present if wildcards are in use
if (($params{'ObjType'} eq '*') || ($params{'ObjType'} eq 'ALL') ||
    ($params{'ObjName'} =~ /\*$/) || ($params{'ObjGroup'} =~ /\*$/)) {
    if (length($params{'ObjectCriteria'}) > 0) {
        print "ERROR: You cannot supply a value for Serialized Resource Object Criteria while using Ubject Type '*' or 'All' or using a masked value for Object Name or Object Group!\n";
        exit -1;
    }
}

# Validate wildcards are at end
if (($params{'ObjName'} =~ /\*.+$/) || ($params{'ObjGroup'} =~ /\*.+$/)) {
    print "ERROR: The wildcard character '*' must only occur at the end of the Object Name or Object Group!\n";
    exit -1;
}

# Validate Object Group against Object Type
if(($params{'ObjType'} eq 'RESGROUP') || ($params{'ObjType'} eq 'RESDESC')) {
    if (length($params{'ObjGroup'}) > 0) {
        print "ERROR: You cannot specify an Object Group when the Object Type is 'ResGroup (Group for CSD)' or 'ResDesc (List for CSD)'!\n";
        exit -1;
    }
}

# Validate ObjDefVer
if (($params{'LocationType'} ne 'Context') && (length($params{'ObjDefVer'}) > 0)) {
    print "ERROR: You cannot specify an Object Definition Version unless the Location Type is 'Context'!\n";
    exit -1;
} elsif ((length($params{'ObjGroup'}) > 0) && (length($params{'ObjDefVer'}) > 0)) {
    print "ERROR: You cannot specify both and Object Group and an Object Definition Version!\n";
    exit -1;
}

if (((length($params{'MONSpecInherit'}) or length($params{'RTASpecInherit'}) or length($params{'WLMSpecInherit'}))) and uc($params{'ResTableName'}) ne "CSGLCGCS") {
    print "ERROR: 'MON Specification Inheritance', 'RTA Specification Inheritance', and 'WLM Specification Inheritance' apply only to CSGLCGCS objects.";
    exit -1;
}

if ((length($params{'LNKSWSCGParm'}) > 0) and uc($params{'ResTableName'}) ne "LNKSWSCG") {
    print "ERROR: 'LNKSWSCG Parameter' applies only to LNKSWSCG objects.";
    exit -1;
}

# Build @ObjectCriteria
my @mParams = ('ObjType', 'ObjName', 'ObjGroup', 'ObjDefVer');
my @ObjectCriteria = createObjectCriteria(\@mParams, 0, "", \%params); 

# Handle optional parameters
my @paramsForRequest = (
    'IntegrityToken',
    'MONSpecInherit',
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
my @ProcessParms;
if (scalar(@paramsForRequestResult) > 0) {
    @ProcessParms = SOAP::Data->name('ProcessParms' => \SOAP::Data->value(@paramsForRequest));
}

my @data =
    SOAP::Data->name($soapMethodName => \SOAP::Data->value(
        SOAP::Data->name('LocationCriteria' => \SOAP::Data->value(
            SoapData('LocationName'),
            SoapData('LocationType')
        )),
        @ObjectCriteria,
        @ProcessParms
    ));

$[/myPlugin/project/ec_perl_code_block_2]
