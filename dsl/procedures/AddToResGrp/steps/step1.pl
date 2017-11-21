$[/myPlugin/project/ec_perl_header]

# Procedure-specific Metadata
# ---------------------------

# Name of SOAP method to call
my $soapMethodName = 'Add';

my @optionalParams = (
    'ObjGroup',
    'ObjDefVer',
    'ObjectCriteria'
);

$[/myPlugin/project/ec_perl_metadata]

$[/myPlugin/project/ec_perl_code_block_1]

# Validation

# Validate ObjGroup and ObjDefVer in context of ObjType asnd LocationType
if($params{'LocationType'} eq 'Context') {
    if ((length($params{'ObjGroup'}) > 0) && (length($params{'ObjDefVer'}) > 0)) {
        print "ERROR: You cannot specify both a Resource Group and a Resource Definition Version!\n";
        exit -1;
    } elsif (!(length($params{'ObjGroup'}) > 0) && !(length($params{'ObjDefVer'}) > 0)) {
        print "ERROR: For objects of Resource Type \'$params{'ObjType'}\' in a Location Type of 'Context', you must specify either a Resource Group value or a Resource Definition Version value!\n";
        exit -1;
    }
} else {
    if (length($params{'ObjDefVer'}) > 0) {
        print "ERROR: You cannot specify an Object Definition Version if the Location Type is not 'Context'!\n";
        exit -1;
    }
    if (!(length($params{'ObjGroup'}) > 0)) {
        print "ERROR: For objects of Resource Type \'$params{'ObjType'}\' in a Location Type of \'$params{'LocationType'}\', you must specify a Resource Group value!\n";
        exit -1;
    }
}

# Procedure-specific Code
# -----------------------

my @mParams = ('ObjGroup', 'ObjName', 'ObjType', 'ObjDefVer');

my @ObjectCriteria = createObjectCriteria(\@mParams, 0, "DefA", \%params);

my @data =
SOAP::Data->name($soapMethodName => \SOAP::Data->value(
    SOAP::Data->name('LocationCriteria' => \SOAP::Data->value(
        SoapData('LocationName'),
        SoapData('LocationType')
    )) ,
    SOAP::Data->name('ObjectCriteria' => @ObjectCriteria),
    SOAP::Data->name('InputData' => \SOAP::Data->value(
        SoapData('ContainerName'),
        SoapData('ContainerType')
    ))
));

$[/myPlugin/project/ec_perl_code_block_2]
