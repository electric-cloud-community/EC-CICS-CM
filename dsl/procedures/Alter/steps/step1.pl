$[/myPlugin/project/ec_perl_header]

# Procedure-specific Metadata
# ---------------------------

# Name of SOAP method to call
my $soapMethodName = 'Alter';

# List of the names of optional paramters
my @optionalParams = (
    'ObjGroup,
    'ObjectCriteria'
);

$[/myPlugin/project/ec_perl_metadata]

$[/myPlugin/project/ec_perl_code_block_1]

# Procedure-specific Code
# -----------------------

# Validate ObjectCriteria isn't present if wildcards are in use
if (($params{'ObjType'} eq '*') || ($params{'ObjType'} eq 'ALL') ||
    ($params{'ObjName'} =~ /\*$/) || ($params{'ObjGroup'} =~ /\*$/)) {
    if (length($params{'ObjectCriteria'}) > 0) {
        print "ERROR: You cannot supply a value for Serialized Resource Object Criteria while using Ubject Type '*' or 'All' or using a masked value for Object Name or Object Group!\n";
        exit -1;
    }
}

# Validate wildcards are at end
if (($params{'ObjName'} =~ /\*.+$/) || ($params{'ObjGroup'} =~ /\*.+$/)) {\
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

# Build @ObjectCriteria
my @ObjectCriteria = createObjectCriteria(\@mParams, 0, "", \%params);

# Build @ObjectData
my @ObjectData = createObjectData($params{'ObjectData'});

my @data =
    SOAP::Data->name($soapMethodName => \SOAP::Data->value(
        SOAP::Data->name('LocationCriteria' => \SOAP::Data->value(
            SoapData('LocationName'),
            SoapData('LocationType')
        )),
        SOAP::Data->name('ObjectCriteria' => @ObjectCriteria),
        SOAP::Data->name('InputData' => \SOAP::Data->value(
            SOAP::Data->name('ObjectData' => \SOAP::Data->value(
	        @ObjectData
            ))
        ))
    ));

$[/myPlugin/project/ec_perl_code_block_2]
