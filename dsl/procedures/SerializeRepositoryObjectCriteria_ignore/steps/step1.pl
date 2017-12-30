$[/myPlugin/project/ec_perl_header]

# Procedure-specific Metadata
# ---------------------------

my $soapMethodName;

# List of the names of optional paramters
my @optionalParams = (
    'ObjectCriteria',
    'ObjName',
    'CPID',
    'CConfig',
    'CICSGroup',
    'CICSObjType',
    'CICSObjName',
    'Scheme'
);

$[/myPlugin/project/ec_perl_metadata]

$[/myPlugin/project/ec_perl_code_block_1]

# Procedure-specific Code
# -----------------------

# Validation

# Validate which optional parameters have been provided against ObjType 
# For a particular ObjType value, some are required, the rest are forbidden
# (for details see comments on ObjType options and the <documentation> tags of the optional parameters in form.xml)
if ($params{'ObjType'} eq 'ChgPkg') {
    if (length($params{'CPID'}) == 0) {
        print "ERROR: Change Package ID must be specified for creating Object Type 'ChgPkg'!\n";
        exit -1;
    }
    if (length($params{'ObjName'}.$params{'CConfig'}.$params{'CICSGroup'}.$params{'CICSObjType'}.$params{'CICSObjName'}.$params{'Scheme'}) > 0) {
        print "ERROR: Only Change Package ID can be specified for creating Object Type 'ChgPkg'!\n";
        exit -1;
    }
} elsif (($params{'ObjType'} eq 'CmdAssociation') || ($params{'ObjType'} eq 'KeyAssociation')) {
    if (length($params{'CPID'}) == 0) {
        print "ERROR: Change Package ID must be specified for creating Object Type \'$params{'ObjType'}\'!\n";
        exit -1;
    }
    if (length($params{'CConfig'}) == 0) {
        print "ERROR: CICS Configuration must be specified for creating Object Type \'$params{'ObjType'}\'!\n";
        exit -1;
    }
    if (length($params{'CICSGroup'}) == 0) {
        print "ERROR: CICS Group must be specified for creating Object Type \'$params{'ObjType'}\'!\n";
        exit -1;
    }
    if (length($params{'CICSObjType'}) == 0) {
        print "ERROR: CICS Object Type must be specified for creating Object Type \'$params{'ObjType'}\'!\n";
        exit -1;
    }
    if (length($params{'CICSObjName'}) == 0) {
        print "ERROR: CICS Object Name must be specified for creating Object Type \'$params{'ObjType'}\'!\n";
        exit -1;
    }
    if (length($params{'ObjName'}.$params{'Scheme'}) > 0) {
        print "ERROR: Neither Object Name nor Scheme can be specified for creating Object Type \'$params{'ObjType'}\'!\n";
        exit -1;
    }
} elsif ($params{'ObjType'} eq 'PScheme') {
    if (length($params{'CPID'}) == 0) {
        print "ERROR: Change Package ID must be specified for creating Object Type 'PScheme'!\n";
        exit -1;
    }
    if (length($params{'Scheme'}) == 0) {
        print "ERROR: Scheme must be specified for creating Object Type 'PScheme'!\n";
        exit -1;
    }
    if (length($params{'ObjName'}.$params{'CConfig'}.$params{'CICSGroup'}.$params{'CICSObjType'}.$params{'CICSObjName'}) > 0) {
        print "ERROR: Only Change Package ID and Scheme can be specified for creating Object Type 'PScheme'!\n";
        exit -1;
    }
} else {
    if (length($params{'ObjName'}) == 0) {
        print "ERROR: Object Name must be specified for creating Object Type \'$params{'ObjType'}\'!\n";
        exit -1;
    }
    if (length($params{'CPID'}.$params{'CConfig'}.$params{'CICSGroup'}.$params{'CICSObjType'}.$params{'CICSObjName'}.$params{'Scheme'}) > 0) {
        print "ERROR: Only Object Name can be specified for creating Object Type \'$params{'ObjType'}\'!\n";
        exit -1;
    }
}

# Procedure-specific validation
       
#### TODO Add procedure-specific validation if needed

# Build @ObjectCriteria
my $tagName = $tagName{$procedure};
if ($tagName eq undef) {
    $tagName = "";
}
my @mParams = ('ObjName', 'CPID', 'CConfig', 'CICSGroup', 'CICSObjType', CICSObjName', 'Scheme'); 
my @ObjectCriteria = createObjectCriteria(\@mParams, 0, "", \%params, 1);

# Convert to XML
my $serializer = SOAP::Serializer->new();
$serializer->autotype(0);
$serializer->readable(1);
my $xml = $serializer->serialize(@ObjectCriteria);

# Remove unneeded leading/enclosing tags
$xml =~ s/^<\?xml [^?]*\?>\s*//s;
$xml =~ s/^<ObjectCriteria(?: xmlns:[^=]+="[^"]+")*\s*>\s*//s;
$xml =~ s/\s*<\/ObjectCriteria\s*>\s*$//s;
$xml =~ s/^<ListCount\s*>[0-9]+<\/ListCount\s*>\s*/  /s;

# Store the XML in the output property
$ec->setProperty($params{'outputProperty'}, {value => $xml});

