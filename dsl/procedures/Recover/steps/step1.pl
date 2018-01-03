$[/myPlugin/project/ec_perl_header]

# Procedure-specific Metadata
# ---------------------------

# Name of SOAP method to call
my $soapMethodName = 'Recover';

# List of the names of optional paramters
my @optionalParams = (
    'ObjGroup',
    'ObjectCriteria',
    'RollbackOption'
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

# Handle optional parameters
if (($params{'RecoverImage'} eq 'After') {
    if (length($params{'RollbackOption'}) > 0) {
        print "ERROR: You cannot specify a Rollback Option when the Recover Image  setting is 'After'!\n";
        exit -1;
    }
}

# Build @ObjectCriteria

my @mParams = ('ObjName', 'ObjGroup', 'ObjType', 'ObjectInstance');
my @ObjectCriteria = createObjectCriteria(\@mParams, 0, "", \%params);

my @data =
    SOAP::Data->name($soapMethodName => \SOAP::Data->value(
        SOAP::Data->name('LocationCriteria' => \SOAP::Data->value(
            SoapData('LocationType')
        )),
        SOAP::Data->name('ObjectCriteria' => @ObjectCriteria),
        SOAP::Data->name('ProcessParms' => \SOAP::Data->value(
            SoapData('RecoverImage'),
            SoapDataOptional('RollbackOption')
        ))
    ));

$[/myPlugin/project/ec_perl_code_block_2]

