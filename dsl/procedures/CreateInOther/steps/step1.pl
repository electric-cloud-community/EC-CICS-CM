$[/myPlugin/project/ec_perl_header]

# Procedure-specific Metadata
# ---------------------------

# Name of SOAP method to call
my $soapMethodName = 'Create';

# List of the names of optional paramters
my @optionalParams = (
    'CSYSDEFModel',
    'MonSpecInherit',
    'RTASpecInherit',
    'WLMSpecInherit',
    'LNKSWSCGParm',
);

$[/myPlugin/project/ec_perl_metadata]

$[/myPlugin/project/ec_perl_code_block_1]

# Validation
#-----------------------------

# Validation for CICSPlex
#if(length($params{'CSYSDEFModel'}) and uc($params{'ResTableName'}) ne "CSYSDEF") {
#    print "ERROR: 'CSYSDEF Model' applies only to CSYSDEF objects.";
#    exit -1;
#}
#
#if(((length($params{'MonSpecInherit'}) or length($params{'RTASpecInherit'}) or length($params{'WLMSpecInherit'}))) and uc($params{'ResTableName'}) ne "CSGLCGCS") {
#    print "ERROR: 'Mon Spec Inherit', 'RTA Spec Inherit', and 'WLM Spec Inherit' apply only to CSGLCGCS objects.";
#    exit -1;
#}
#
#if(length($params{'LNKSWSCGParm'}) and uc($params{'ResTableName'}) ne "LNKSWSCG") {
#    print "ERROR: 'LNKSWSCG Parameter' applies only to LNKSWSCG objects.";
#    exit -1;
#}

# Procedure-specific Code
# -----------------------

# Split and parse ObjectData

my @ObjectData = createObjectData($params{'ObjectData'});

# Build @ObjectCriteria

my @objCriteriaResult;
my @objCriteriaParams = ('ObjGroup', 'ObjType', 'ObjName', 'ObjDefVer');
for my $p (@objCriteriaParams) {
    if (defined $params{$p} && $params{$p} ne "") {
        push @objCriteriaResult, SoapData($p);
    }
}

my @ObjectCriteria;
if ( $params{'ObjType'} && !$params{'ObjectCriteria'}) {

    # No ObjectCriteria, so we only have one element, and can ommit the <ListCount> and <ListElement>
    @ObjectCriteria = SOAP::Data->name('ObjectCriteria' => \SOAP::Data->value(
        @objCriteriaResult
    ));
} else {

    # Combine ObjName, ObjGroup, ObjType, and ObjectCriteria into @ObjectCriteria
    my $objectCriteria = $params{'ObjectCriteria'};
    @ObjectCriteria = SOAP::Data->name('ObjectCriteria' => \SOAP::Data->value(
        @objCriteriaResult,
        SOAP::Data->type('xml' => $objectCriteria)
    ));
}

# Handle optional parametrs
my @paramsForRequest;
my @paramsForRequestResult;
for my $p (@optionalParams) {
    if ($params{$p} ne "") {
        push @paramsForRequest, SoapData($p);
    }
}

if(scalar(@paramsForRequest) > 0) {
    push  @paramsForRequestResult, SOAP::Data->name('ProcessParms' => \SOAP::Data->value(@paramsForRequest));
}

my @data =
SOAP::Data->name($soapMethodName => \SOAP::Data->value(
    SOAP::Data->name('LocationCriteria' => \SOAP::Data->value(
        SoapData('LocationName'),
        SoapData('LocationType')
    )),
    SOAP::Data->name('ObjectCriteria' => @ObjectCriteria),
    SOAP::Data->name('InputData' => \SOAP::Data->value(
        SOAP::Data->name('ObjectData' => \SOAP::Data->value(@ObjectData)),
    )),
    @paramsForRequestResult
));

$[/myPlugin/project/ec_perl_code_block_2]
