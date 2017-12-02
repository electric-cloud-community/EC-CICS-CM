$[/myPlugin/project/ec_perl_header]

# Procedure-specific Metadata
# ---------------------------

# Name of SOAP method to call
my $soapMethodName = 'Update';

# List of the names of optional paramters
my @optionalParams = (
    'ObjName',
    'CPID',
    'CConfig',
    'CICSGroup',
    'CICSObjType',
    'CICSObjName',
    'Scheme',
    'IntegrityToken'
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
        print "ERROR: Change Package ID must be specified for deleting Object Type 'ChgPkg'!\n";
        exit -1;
    }
    if (length($params{'ObjName'}.$params{'CConfig'}.$params{'CICSGroup'}.$params{'CICSObjType'}.$params{'CICSObjName'}.$params{'Scheme'}) > 0) {
        print "ERROR: Only Change Package ID can be specified for deleting Object Type 'ChgPkg'!\n";
        exit -1;
    }
} elsif (($params{'ObjType'} eq 'CmdAssociation') || ($params{'ObjType'} eq 'KeyAssociation')) {
    if (length($params{'CPID'}) == 0) {
        print "ERROR: Change Package ID must be specified for deleting Object Type \'$params{'ObjType'}\'!\n";
        exit -1;
    }
    if (length($params{'CConfig'}) == 0) {
        print "ERROR: CICS Configuration must be specified for deleting Object Type \'$params{'ObjType'}\'!\n";
        exit -1;
    }
    if (length($params{'CICSGroup'}) == 0) {
        print "ERROR: CICS Group must be specified for deleting Object Type \'$params{'ObjType'}\'!\n";
        exit -1;
    }
    if (length($params{'CICSObjType'}) == 0) {
        print "ERROR: CICS Object Type must be specified for deleting Object Type \'$params{'ObjType'}\'!\n";
        exit -1;
    }
    if (length($params{'CICSObjName'}) == 0) {
        print "ERROR: CICS Object Name must be specified for deleting Object Type \'$params{'ObjType'}\'!\n";
        exit -1;
    }
    if (length($params{'ObjName'}.$params{'Scheme'}) > 0) {
        print "ERROR: Neither Object Name nor Scheme can be specified for deleting Object Type \'$params{'ObjType'}\'!\n";
        exit -1;
    }
} elsif ($params{'ObjType'} eq 'PScheme') {
    if (length($params{'CPID'}) == 0) {
        print "ERROR: Change Package ID must be specified for deleting Object Type 'PScheme'!\n";
        exit -1;
    }
    if (length($params{'Scheme'}) == 0) {
        print "ERROR: Scheme must be specified for deleting Object Type 'PScheme'!\n";
        exit -1;
    }
    if (length($params{'ObjName'}.$params{'CConfig'}.$params{'CICSGroup'}.$params{'CICSObjType'}.$params{'CICSObjName'}) > 0) {
        print "ERROR: Only Change Package ID and Scheme can be specified for deleting Object Type 'PScheme'!\n";
        exit -1;
    }
} else {
    if (length($params{'ObjName'}) == 0) {
        print "ERROR: Object Name must be specified for deleting Object Type \'$params{'ObjType'}\'!\n";
        exit -1;
    }
    if (length($params{'CPID'}.$params{'CConfig'}.$params{'CICSGroup'}.$params{'CICSObjType'}.$params{'CICSObjName'}.$params{'Scheme'}) > 0) {
        print "ERROR: Only Object Name can be specified for deleting Object Type \'$params{'ObjType'}\'!\n";
        exit -1;
    }
}

my @ObjectData = createObjectData($params{'ObjectData'}, 1); # 1 to allow XML values

# Handle optional Process Parameters
my @processParmsResult;
if (length($params{'IntegrityToken'}) > 0) {
    push @processParmsResult, SoapData($param);
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
        SOAP::Data->name('ObjectCriteria' => \SOAP::Data->value(
            SoapData('ObjType'),
            SoapDataOptional('ObjName'),
            SoapDataOptional('CPID'),
            SoapDataOptional('CICSGroup'),
            SoapDataOptional('CICSObjType'),
            SoapDataOptional('CICSObjName'),
            SoapDataOptional('Scheme')
        )),
        @ProcessParms,
        SOAP::Data->name('InputData' => \SOAP::Data->value(
            SOAP::Data->name('ObjectData' => \SOAP::Data->value(
	        @ObjectData
            ))
        ))
    ));

$[/myPlugin/project/ec_perl_code_block_2]
