$[/myPlugin/project/ec_perl_header]

# Procedure-specific Metadata
# ---------------------------

# Name of SOAP method to call
my $soapMethodName = 'Copy';

# List of the names of optional paramters
my @optionalParams = (
    'ObjectCriteria',
    'TargetLocationGroup'.
    'Replace'
);

$[/myPlugin/project/ec_perl_metadata]

$[/myPlugin/project/ec_perl_code_block_1]

# Procedure-specific Code
# -----------------------

# Validate TargetGroup if required
if (($params{'LocationName'} eq $params{'TargetLocationName'}) && ($params{'LocationName'} eq $params{'TargetLocationName'})) {
    if (!(length($params{'TargetGroup'}) > 0)) {
        print "ERROR: Target Group must be specified if Target Location Name matches Location Name and Target Location Type matches LocationType!\n";
        exit -1;
    } elsif ((!(length($params{'TargetGroup'}) > 0)) && ($params{'ObjGroup'} eq $params{'TargetGroup'})) {
        print "ERROR: Target Group must not match Object Group if Target Location Name matches Location Name and Target Location Type matches LocationType!\n";
        exit -1;
    }
}

# Build @ObjectCriteria
my @mParams = ('ObjName', 'ObjGroup', 'ObjType');
my @ObjectCriteria = createObjectCriteria(\@mParams, 0, "", \%params); #### TODO Should this include ListCount if it's equal to 1?

my @data =
    SOAP::Data->name($soapMethodName => \SOAP::Data->value(
        SOAP::Data->name('LocationCriteria' => \SOAP::Data->value(
            SoapData('LocationName'),
            SoapData('LocationType')
        )),
        SOAP::Data->name('ObjectCriteria' => @ObjectCriteria),
        SOAP::Data->name('InputData' => \SOAP::Data->value(
            SoapData('TargetLocationName'),
            SoapData('TargetLocationType'),
            SoapDataOptional('TargetLocationGroup')
        )),
        SOAP::Data->name('ProcessParms' => \SOAP::Data->value(
            SoapDataOptional('Replace')
        ))
    ));

$[/myPlugin/project/ec_perl_code_block_2]
