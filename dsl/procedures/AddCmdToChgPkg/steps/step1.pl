$[/myPlugin/project/ec_perl_header]

# Procedure-specific Metadata
# ---------------------------

# Name of SOAP method to call
my $soapMethodName = 'Add';

# List of the names of optional paramters
my @optionalParams = (
    'ObjGroup',
    'ObjDefVer',
    'TContainer',
    'ObjectCriteria'
);

$[/myPlugin/project/ec_perl_metadata]

$[/myPlugin/project/ec_perl_code_block_1]

# Procedure-specific Code
# -----------------------

# Validation

# Validate ObjGroup and ObjDefVer in context of ObjType
if(($params{'ObjType'} eq 'RESGROUP') || ($params{'ObjType'} eq 'RESDESC')) {
    if (length($params{'ObjGroup'}) > 0) {
        print "ERROR: You cannot specify an Object Group when the Object Type is 'ResGroup (Group for CSD)' or 'ResDesc (List for CSD)'!\n";
        exit -1;
    }
} else {
    if ((length($params{'ObjGroup'}) > 0) && (length($params{'ObjDefVer'}) > 0)) {
        print "ERROR: You cannot specify both an Object Group and an Object Definition Version!\n";
        exit -1;
    } elsif (!(length($params{'ObjGroup'}) > 0) && !(length($params{'ObjDefVer'}) > 0)) {
        print "ERROR: For objects of type \'$params{'ObjType'}\', you must specify either an Object Group value or an Object Definition Version value!\n";
        exit -1;
    }
}    

# Validate TContainer in the context of Command
if(($params{'Command'} ne 'Add') and (length($params{'TContainer'}) > 0)) {
    print "ERROR: 'Target Resource Group For Add' is relevant only when packaging an Add command. It identifies the Resource Group to which you want the resource definitions added.";
    exit -1;
}

my @mParams = ('Command', 'ObjGroup', 'ObjName', 'ObjType', 'ObjDefVer', 'TContainer');
my @ObjectCriteria = createObjectCriteria(\@mParams, 1, "CmdAPost", \%params);  # 1 is to add CConfig

my @data =
    SOAP::Data->name($soapMethodName => \SOAP::Data->value(
        SOAP::Data->name('LocationCriteria' => \SOAP::Data->value(
            SoapData('LocationType')
        )),
        @ObjectCriteria,
        SOAP::Data->name('InputData' => \SOAP::Data->value(
            SoapData('ContainerName'),
            SoapData('ContainerType')
        ))
    ));

$[/myPlugin/project/ec_perl_code_block_2]
