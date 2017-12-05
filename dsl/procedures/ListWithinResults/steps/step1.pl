$[/myPlugin/project/ec_perl_header]

# Procedure-specific Metadata
# ---------------------------

# Name of SOAP method to call
my $soapMethodName = 'List';

# List of the names of optional paramters
my @optionalParams = (
    'ObjGroup',
    'ObjDefVer',
    'ObjectCriteria',
    'RestrictionCriteria'
);

$[/myPlugin/project/ec_perl_metadata]

$[/myPlugin/project/ec_perl_code_block_1]

# Procedure-specific Code
# -----------------------

# Validate wildcards are at end #### TODO Are wildcards allowed here?
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

# Build @ObjectCriteria, ensuring that <ElementCount>1</ElementCount> happens if needed
my @mParams = ('ObjType', 'ObjName', 'ObjGroup', 'ObjDefVer');
my @ObjectCriteria = createObjectCriteria(\@mParams, 0, "", \%params, 1);  # 1 to wrap and add count even for single element

# Split and parse optional RestrictionCriteria
my @RestrictionCriteria = makeRestrictionCriteria($params{'RestrictionCriteria'});

# Handle optional Process Parameters
my @processParmsResult;
my @processParmsParameters = ('AllAttributes', 'HashingScope', 'Counts', 'FilterDate', 'Limit', 'ReportSet');
for my $param (@processParmsParameters) {
    if (length($params{$param}) > 0) {
        push @processParmsResult, SoapData($param);
    }
}
my @ProcessParms;
if(scalar(@processParmsResult) > 0) {
    @ProcessParms =
        SOAP::Data->name('ProcessParms' => \SOAP::Data->value(
            @processParmsResult
        ));
}

my @data =
    SOAP::Data->name($soapMethodName => \SOAP::Data->value(
        SOAP::Data->name('LocationCriteria' => \SOAP::Data->value(
            SoapData('LocationName'),
            SoapData('LocationType')
        )),
        @ObjectCriteria,
        @RestrictionCriteria
    ));

$[/myPlugin/project/ec_perl_code_block_2]
