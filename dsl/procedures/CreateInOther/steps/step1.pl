$[/myPlugin/project/ec_perl_header]

# Procedure-specific Metadata
# ---------------------------

# Name of SOAP method to call
my $soapMethodName = 'Create';

# List of the names of optional paramters
my @optionalParams = (
    'ObjGroup',
    'ObjectData',
    'CSYSDEFModel',
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

# Validate Object Group against Object Type
if (($params{'ObjType'} eq 'RESGROUP') || ($params{'ObjType'} eq 'RESDESC')) {
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

if (length($params{'CSYSDEFModel'}) and uc($params{'ObjType'}) ne "CSYSDEF") {
    print "ERROR: 'CSysDef Model' applies only to CSysDef objects.";
    exit -1;
}

if (((length($params{'MONSpecInherit'}) or length($params{'RTASpecInherit'}) or length($params{'WLMSpecInherit'}))) and uc($params{'ResTableName'}) ne "CSGLCGCS") {
    print "ERROR: 'MON Specification Inheritance', 'RTA Specification Inheritance', and 'WLM Specification Inheritance' apply only to CSGLCGCS objects.";
    exit -1;
}

if (length($params{'LNKSWSCGParm'}) and uc($params{'ResTableName'}) ne "LNKSWSCG") {
    print "ERROR: 'LNKSWSCG Parameter' applies only to LNKSWSCG objects.";
    exit -1;
}

# Handle optional parameters

# Split, parse and build ObjectData
my @ObjectData;
if (length($params{'ObjectData'}) > 0 ) {
    @ObjectData = createObjectData($params{'ObjectData'});
} else {
    @ObjectData = SOAP::Data->type('xml' => '<!-- -->');  # Work around various bugs in ISPW SOAP interface
}

my @paramsForRequest = (
    'CSYSDEFModel',
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
            SoapDataOptional('ObjGroup')
        )),
        SOAP::Data->name('InputData' => \SOAP::Data->value(
            SOAP::Data->name('ObjectData' => \SOAP::Data->value(@ObjectData)),
        )),
        @processParms
));

$[/myPlugin/project/ec_perl_code_block_2]
