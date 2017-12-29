$[/myPlugin/project/ec_perl_header]

# Procedure-specific Metadata
# ---------------------------

# Name of SOAP method to call
my $soapMethodName = 'Inquire';

# List of the names of optional paramters
my @optionalParams = (
    'report',
    'ObjName',
    'CPID',
    'CConfig',
    'CICSGroup',
    'CICSObjType',
    'CICSObjName',
    'Scheme',
    'ObjectInstance'
);

$[/myPlugin/project/ec_perl_metadata]

$[/myPlugin/project/ec_perl_code_block_1]

# Procedure-specific Code
# -----------------------

# Validate which optional parameters have been provided against ObjType 
# For a particular ObjType value, some are required, the rest are forbidden
# (for details see comments on ObjType options and the <documentation> tags of the optional parameters in form.xml)
if ($params{'ObjType'} eq 'ChgPkg') {
    if (length($params{'CPID'}) == 0) {
        print "ERROR: Change Package ID must be specified for inquiring contents of Object Type 'ChgPkg'!\n";
        exit -1;
    }
    if (length($params{'ObjName'}.$params{'CConfig'}.$params{'CICSGroup'}.$params{'CICSObjType'}.$params{'CICSObjName'}.$params{'Scheme'}) > 0) {
        print "ERROR: Only Change Package ID can be specified for inquiring the contents of Object Type 'ChgPkg'!\n";
        exit -1;
    }
} elsif (($params{'ObjType'} eq 'CmdAssociation') || ($params{'ObjType'} eq 'KeyAssociation')) {
    if (length($params{'CPID'}) == 0) {
        print "ERROR: Change Package ID must be specified for inquiring the contents of Object Type \'$params{'ObjType'}\'!\n";
        exit -1;
    }
    if (length($params{'CConfig'}) == 0) {
        print "ERROR: CICS Configuration must be specified for inquiring the contents of Object Type \'$params{'ObjType'}\'!\n";
        exit -1;
    }
    if (length($params{'CICSGroup'}) == 0) {
        print "ERROR: CICS Group must be specified for inquiring the contents of Object Type \'$params{'ObjType'}\'!\n";
        exit -1;
    }
    if (length($params{'CICSObjType'}) == 0) {
        print "ERROR: CICS Object Type must be specified for inquiring the contents of Object Type \'$params{'ObjType'}\'!\n";
        exit -1;
    }
    if (length($params{'CICSObjName'}) == 0) {
        print "ERROR: CICS Object Name must be specified for inquiring the contents of Object Type \'$params{'ObjType'}\'!\n";
        exit -1;
    }
    if (length($params{'ObjName'}.$params{'Scheme'}) > 0) {
        print "ERROR: Neither Object Name nor Scheme can be specified for inquiring the contents of Object Type \'$params{'ObjType'}\'!\n";
        exit -1;
    }
} elsif (($params{'ObjType'} eq 'PScheme') || ($params{'ObjType'} eq 'ReadyLst')) {
    if (length($params{'CPID'}) == 0) {
        print "ERROR: Change Package ID must be specified for inquiring the contents of Object Type \'$params{'ObjType'}\'!\n";
        exit -1;
    }
    if (length($params{'Scheme'}) == 0) {
        print "ERROR: Scheme must be specified for inquiring the contents of Object Type \'$params{'ObjType'}\'!\n";
        exit -1;
    }
    if (length($params{'ObjName'}.$params{'CConfig'}.$params{'CICSGroup'}.$params{'CICSObjType'}.$params{'CICSObjName'}) > 0) {
        print "ERROR: Only Change Package ID and Scheme can be specified for the inquiring contents of Object Type \'$params{'ObjType'}\'!\n";
        exit -1;
    }
} elsif (($params{'ObjType'} eq 'SvrInfo') || ($params{'ObjType'} eq 'SysOpts')) {
    if (length($params{'ObjName'}.$params{'CPID'}.$params{'CConfig'}.$params{'CICSGroup'}.$params{'CICSObjType'}.$params{'CICSObjName'}.$params{'Scheme'}) > 0) {
        print "ERROR: No object criteria vslues can be specified for inquiring the contents of Object Type \'$params{'ObjType'}\'!\n";
        exit -1;
    }
} elsif ($params{'ObjType'} eq 'Scheme') {
    if (length($params{'ObjName'}) == 0) {
        print "ERROR: Object Name must be specified for inquiring the contents of Object Type 'Scheme'!\n";
        exit -1;
    }
    if (length($params{'Scheme'}) == 0) {
        print "ERROR: Object Name must be specified for inquiring the contents of Object Type 'Scheme'!\n";
        exit -1;
    }
    if (length($params{'CPID'}.$params{'CConfig'}.$params{'CICSGroup'}.$params{'CICSObjType'}.$params{'CICSObjName'}) > 0) {
        print "ERROR: Only Object Name can be specified for inquiring the contents of Object Type 'Scheme'!\n";
        exit -1;
    }
} else {
    if (length($params{'ObjName'}) == 0) {
        print "ERROR: Object Name must be specified for inquiring the contents of Object Type \'$params{'ObjType'}\'!\n";
        exit -1;
    }
    if (length($params{'CPID'}.$params{'CConfig'}.$params{'CICSGroup'}.$params{'CICSObjType'}.$params{'CICSObjName'}.$params{'Scheme'}) > 0) {
        print "ERROR: Only Object Name can be specified for inquiring the contents of Object Type \'$params{'ObjType'}\'!\n";
        exit -1;
    }
}

my @data =
    SOAP::Data->name($soapMethodName => \SOAP::Data->value(
        SOAP::Data->name('LocationCriteria' => \SOAP::Data->value(
            SoapData('LocationType')
        )),
        SOAP::Data->name('ObjectCriteria' => \SOAP::Data->value(
            SoapData('ObjType'),
            SoapDataOptional('ObjName'),
            SoapDataOptional('CPID'),
            SoapDataOptional('CConfig'),
            SoapDataOptional('CICSGroup'),
            SoapDataOptional('CICSObjType'),
            SoapDataOptional('CICSObjName'),
            SoapDataOptional('Scheme'),
            SoapDataOptional('ObjectInstance')
        ))
    ));

$[/myPlugin/project/ec_perl_code_block_2]
