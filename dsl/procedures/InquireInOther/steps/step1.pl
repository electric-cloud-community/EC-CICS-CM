$[/myPlugin/project/ec_perl_header]

# Procedure-specific Metadata
# ---------------------------

# Name of SOAP method to call
my $soapMethodName = 'Inquire';

# List of the names of optional paramters
my @optionalParams = (
    'report',
    'ObjGroup',
    'ObjDefVer',
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
            SoapDataOptional('ObjDefVer'),
        ))
    ));

$[/myPlugin/project/ec_perl_code_block_2]
