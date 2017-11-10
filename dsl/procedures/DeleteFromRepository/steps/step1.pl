$[/myPlugin/project/ec_perl_header]

# Procedure-specific Metadata
# ---------------------------

# Name of SOAP method to call
my $soapMethodName = 'Delete';

# List of the names of optional paramters
my @optionalParams = (
    'ObjectInstance',
    'ObjName',
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
#### TODO For a particular ObjType value, some are forbidden, some are required, and there may also be some that are allowed
#### (for details see comments on ObjType options and the <documentation> tags of the optional parameters in form.xml)
if ($params{'ObjType'} eq 'ChgPkg') {
    if (length($params{'CPID'}) == 0) {
        print "ERROR: Change Package ID must be specified for Object Type 'ChgPkg'!\n";
        exit -1;
    }
    if (length($params{'ObjName'}.$params{'CConfig'}.$params{'CICSGroup'}.$params{'CICSObjType'}.$params{'CICSObjName'}.$params{'Scheme'}) > 0) {
        print "ERROR: Only Change Package ID can be specified for Object Type 'ChgPkg'!\n";
        exit -1;
    }
} elsif (($params{'ObjType'} eq 'CmdAssociation') || ($params{'ObjType'} eq 'KeyAssociation')) {
    #### TODO CPID, CConfig, CICSGroup, CICSObjType, CICSObjName allowed, not sure whether any are optional 
    if (length($params{'ObjName'}.$params{'Scheme'}) > 0) {
        print "ERROR: Neither Object Name nor Scheme can be specified for Object Type \'$params{'ObjType'}\'!\n";
        exit -1;
    }
} elsif ($params{'ObjType'} eq 'PScheme') {
    #### TODO CPID, Scheme  allowed, not sure whether any are optional 
    if (length($params{'ObjName'}.$params{'CConfig'}.$params{'CICSGroup'}.$params{'CICSObjType'}.$params{'CICSObjName'}) > 0) {
        print "ERROR: Only Change Package ID and Scheme can be specified for Object Type 'PScheme'!\n";
        exit -1;
    }
} else {
    if (length($params{'ObjName'}) == 0) {
        print "ERROR: Object Name must be specified for Object Type \'$params{'ObjType'}\'!\n";
        exit -1;
    }
    if (length($params{'CPID'}.$params{'CConfig'}.$params{'CICSGroup'}.$params{'CICSObjType'}.$params{'CICSObjName'}.$params{'Scheme'}) > 0) {
        print "ERROR: Only Object Name can be specified for Object Type \'$params{'ObjType'}\'!\n";
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
$[/javascript (('' + myParent.ObjectInstance).length == 0) ? "" :
"            SoapData('ObjectInstance'),  # optional parameter "
]
$[/javascript (('' + myParent.ObjName).length == 0) ? "" :
"            SoapData('ObjName'),  # optional parameter "
]
$[/javascript (('' + myParent.CPID).length == 0) ? "" :
"            SoapData('CPID'),  # optional parameter "
]
$[/javascript (('' + myParent.CICSGroup).length == 0) ? "" :
"            SoapData('CICSGroup'),  # optional parameter "
]
$[/javascript (('' + myParent.CICSObjType).length == 0) ? "" :
"            SoapData('CICSObjType'),  # optional parameter "
]
$[/javascript (('' + myParent.CICSObjName).length == 0) ? "" :
"            SoapData('CICSObjName'),  # optional parameter "
]
$[/javascript (('' + myParent.Scheme).length == 0) ? "" :
"            SoapData('Scheme'),  # optional parameter \n"
]
        )),
$[/javascript (('' + myParent.IntegrityToken).length == 0) ? "" :
"        SOAP::Data->name('ProcessParms' => \\SOAP::Data->value(  # Optional section \n" +
"            SoapData('IntegrityToken') \n" +
"        )) "
]
    ));

$[/myPlugin/project/ec_perl_code_block_2]
