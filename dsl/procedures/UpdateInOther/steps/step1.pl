$[/myPlugin/project/ec_perl_header]

# Procedure-specific Metadata
# ---------------------------

# Name of SOAP method to call
my $soapMethodName = 'Update';

# List of the names of optional paramters
my @optionalParams = (
    'ObjGroup',
    'ObjDefVer',
    'IntegrityToken',
    'CSYSDEFModel'
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

my @ObjectData = createObjectData($params{'ObjectData'});

# Handle optional Process Parameters
my @processParmsResult;
my @processParmsParameters = ('IntegrityToken', 'CSYSDEFModel');
for my $param (@processParmsParameters) {
    if (length($params{'IntegrityToken'}) > 0) {
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
        SOAP::Data->name('ObjectCriteria' => \SOAP::Data->value(
	        SoapData('ObjType'),
	        SoapData('ObjName'),
	        SoapDataOptional('ObjGroup'),
	        SoapDataOptional('ObjDefVer')
        )),
        @ProcessParms,
        SOAP::Data->name('InputData' => \SOAP::Data->value(
            SOAP::Data->name('ObjectData' => \SOAP::Data->value(
	        @ObjectData
	    ))
        ))
    ));

$[/myPlugin/project/ec_perl_code_block_2]
