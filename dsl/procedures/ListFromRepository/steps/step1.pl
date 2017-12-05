$[/myPlugin/project/ec_perl_header]

# Procedure-specific Metadata
# ---------------------------

# Name of SOAP method to call
my $soapMethodName = 'List';

# List of the names of optional paramters
my @optionalParams = (
    'ObjName',
    'CPID',
    'CConfig',
    'CICSGroup',
    'CICSObjType',
    'CICSObjName',
    'Scheme',
    'RestrictionCriteria',
    'HashingScope',
    'ObjectHistory',
    'CPIDFormula',
    'Counts',
    'FilterDate',
    'Limit'
);

$[/myPlugin/project/ec_perl_metadata]

$[/myPlugin/project/ec_perl_code_block_1]

# Procedure-specific Code
# -----------------------

# Validate wildcards are at end
if (($params{'ObjName'} =~ /\*.+$/) ||
    ($params{'CPID'} =~ /\*.+$/) ||
    ($params{'CConfig'} =~ /\*.+$/) ||
    ($params{'CICSGroup'} =~ /\*.+$/) ||
    ($params{'CICSObjType'} =~ /\*.+$/) ||
    ($params{'CICSObjName'} =~ /\*.+$/) ||
    ($params{'Scheme'} =~ /\*.+$/)) {
    print "ERROR: The wildcard character '*' must only occur at the end of the Object Name, CPID, Change Package ID, CICS Configuration, CICS Group, CICS Object Type, CICS Object Name or Scheme value!\n";
    exit -1;
}

# Validate which object criteria have been provided against ObjType 
# For a particular ObjType value, some are required, the rest are forbidden
# (for details see comments on ObjType options and the <documentation> tags of the optional parameters in form.xml)
if ($params{'ObjType'} eq 'ChgPkg') {
    if (length($params{'CPID'}) == 0) {
        print "ERROR: Change Package ID must be specified for listing Object Type 'ChgPkg'!\n";
        exit -1;
    }
    if (length($params{'ObjName'}.$params{'CConfig'}.$params{'CICSGroup'}.$params{'CICSObjType'}.$params{'CICSObjName'}.$params{'Scheme'}) > 0) {
        print "ERROR: Only Change Package ID can be specified for listing Object Type 'ChgPkg'!\n";
        exit -1;
    }
} elsif (($params{'ObjType'} eq 'CmdAssociation') || ($params{'ObjType'} eq 'KeyAssociation')) {
    if (length($params{'CPID'}) == 0) {
        print "ERROR: Change Package ID must be specified for listing Object Type \'$params{'ObjType'}\'!\n";
        exit -1;
    }
    if (length($params{'CConfig'}) == 0) {
        print "ERROR: CICS Configuration must be specified for listing Object Type \'$params{'ObjType'}\'!\n";
        exit -1;
    }
    if (length($params{'CICSGroup'}) == 0) {
        print "ERROR: CICS Group must be specified for listing Object Type \'$params{'ObjType'}\'!\n";
        exit -1;
    }
    if (length($params{'CICSObjType'}) == 0) {
        print "ERROR: CICS Object Type must be specified for listing Object Type \'$params{'ObjType'}\'!\n";
        exit -1;
    }
    if (length($params{'CICSObjName'}) == 0) {
        print "ERROR: CICS Object Name must be specified for listing Object Type \'$params{'ObjType'}\'!\n";
        exit -1;
    }
    if (length($params{'ObjName'}.$params{'Scheme'}) > 0) {
        print "ERROR: Neither Object Name nor Scheme can be specified for listing Object Type \'$params{'ObjType'}\'!\n";
        exit -1;
    }
} elsif (($params{'ObjType'} eq 'PScheme') || ($params{'ObjType'} eq 'ReadyLst')) {
    if (length($params{'CPID'}) == 0) {
        print "ERROR: Change Package ID must be specified for listing Object Type \'$params{'ObjType'}\'!\n";
        exit -1;
    }
    if (length($params{'Scheme'}) == 0) {
        print "ERROR: Scheme must be specified for listing Object Type \'$params{'ObjType'}\!\n";
        exit -1;
    }
    if (length($params{'ObjName'}.$params{'CConfig'}.$params{'CICSGroup'}.$params{'CICSObjType'}.$params{'CICSObjName'}) > 0) {
        print "ERROR: Only Change Package ID and Scheme can be specified for listing Object Type \'$params{'ObjType'}\!\n";
        exit -1;
    }
} elsif (($params{'ObjType'} eq 'SvrInfo') || ($params{'ObjType'} eq 'SysOpts')) {
    if (length($params{'ObjName'}.$params{'CPID'}.$params{'CConfig'}.$params{'CICSGroup'}.$params{'CICSObjType'}.$params{'CICSObjName'}.$params{'Scheme'}) > 0) {
        print "ERROR: No object criteria vslues can be specified for inquiring the contents of Object Type \'$params{'ObjType'}\'!\n";
        exit -1;
    }
} elsif (($params{'ObjType'} eq '*') || ($params{'ObjType'} eq 'All')) {
    if (length($params{'ObjName'}.$params{'CPID'}.$params{'CConfig'}.$params{'CICSGroup'}.$params{'CICSObjType'}.$params{'CICSObjName'}.$params{'Scheme'}) > 0) {
        print "ERROR: No other object criteria can be specified for listing Object Type \'$params{'ObjType'}\'!\n";
        exit -1;
    }
} else {
    if (length($params{'ObjName'}) == 0) {
        print "ERROR: Object Name must be specified for listing Object Type \'$params{'ObjType'}\'!\n";
        exit -1;
    }
    if (length($params{'CPID'}.$params{'CConfig'}.$params{'CICSGroup'}.$params{'CICSObjType'}.$params{'CICSObjName'}.$params{'Scheme'}) > 0) {
        print "ERROR: Only Object Name can be specified for listing Object Type \'$params{'ObjType'}\'!\n";
        exit -1;
    }
}

# Split and parse optional RestrictionCriteria
my @RestrictionCriteria = makeRestrictionCriteria($params{'RestrictionCriteria'});

# Handle optional Process Parameters
my @processParmsResult;
my @processParmsParameters = ('HashingScope', 'ObjectHistory', 'CPIDFormula', 'Counts', 'FilterDate', 'Limit');
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
            SoapData('LocationType')
        )),
        SOAP::Data->name('ObjectCriteria' => \SOAP::Data->value(
            SoapData('ObjType'),
            SoapDataOptional('CPID'),
            SoapDataOptional('CConfig'),
            SoapDataOptional('CICSGroup'),
            SoapDataOptional('CICSObjType'),
            SoapDataOptional('CICSObjName'),
            SoapDataOptional('Scheme')
        )),
        @RestrictionCriteria,
        @ProcessParms
    ));

$[/myPlugin/project/ec_perl_code_block_2]
