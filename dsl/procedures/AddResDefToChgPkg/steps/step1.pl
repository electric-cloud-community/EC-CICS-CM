$[/myPlugin/project/ec_perl_header]

# Procedure-specific Metadata
# ---------------------------

# Name of SOAP method to call
my $soapMethodName = 'Add'; 

# List of the names of optional paramters
my @optionalParams = (
    'ObjectCriteria'
);

$[/myPlugin/project/ec_perl_metadata]

$[/myPlugin/project/ec_perl_code_block_1]

# Procedure-specific Code
# -----------------------

# Validate Object Group against Object Type
if(($params{'ObjType'} eq 'RESGROUP') || ($params{'ObjType'} eq 'RESDESC')) {
    if (length($params{'ObjGroup'}) > 0) {
        print "ERROR: You cannot specify an Object Group when the Object Type is 'ResGroup (Group for CSD)' or 'ResDesc (List for CSD)'!\n";
        exit -1;
    }
}

# Build @ObjectCriteria

my @mParams = ('ObjGroup', 'ObjType', 'ObjName'); 
my @ObjectCriteria = createObjectCriteria(\@mParams, 1, "KeyA", \%params);  # 1 to add CConfig

my @data  =
    SOAP::Data->name($soapMethodName => \SOAP::Data->value(
        SOAP::Data->name('LocationCriteria' => \SOAP::Data->value(
            SoapData('LocationType')
        )),
        SOAP::Data->name('ObjectCriteria' => @ObjectCriteria),
        SOAP::Data->name('InputData' => \SOAP::Data->value(
            SoapData('ContainerName'),
            SoapData('ContainerType')
        ))
    ));

$[/myPlugin/project/ec_perl_code_block_2]
