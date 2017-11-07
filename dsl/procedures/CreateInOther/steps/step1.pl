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

# Uncomment bellow verifications when we start support CICSPlex SM
#if($params{'CSYSDEFModel'} and uc($params{'ResTableName'}) ne "CSYSDEF") {
#    print "ERROR: 'CSYSDEFModel' applies only to CSYSDEF objects.";
#    exit -1;
#}
#
#if(($params{'MonSpecInherit'} or $params{'RTASpecInherit'} or $params{'WLMSpecInherit'}) and uc($params{'ResTableName'}) ne "CSGLCGCS") {
#    print "ERROR: 'MonSpecInherit', 'RTASpecInherit', and 'WLMSpecInherit' apply only to CSGLCGCS.";
#    exit -1;
#}
#
#if($params{'LNKSWSCGParm'} and uc($params{'ResTableName'}) ne "LNKSWSCG") {
#    print "ERROR: 'LNKSWSCGParm' applies only to LNKSWSCG objects.";
#    exit -1;
#}

if((!$params{'ObjType'} and !$params{'ObjName'} and !$params{'ObjGroup'}) or !$params{'ObjectCriteria'}) {
    print "ERROR: Eeather 'ObjectCrireria' in xml or entry for 'ObjName', 'ObjGroup' and 'ObjType' should be filled.";
    exit -1;
}

# Procedure-specific Code
# -----------------------

# Build @ObjectCriteria

my @objCriteriaResult;
my @objCriteriaParams = ('ObjGroup', 'ObjType', 'ObjName');
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
for my $p (@optionalParams) {
    if ($params{$p} ne "") {
        push @paramsForRequest, "<$p>$params{$p}</$p>";
    }
}

if(scalar(@paramsForRequest) > 0) {
   unshift @paramsForRequest, "<ProcessParms>";
   push @paramsForRequest, "</ProcessParms>";
}
my $processParmsXml = "@paramsForRequest";

my @data =
SOAP::Data->name($soapMethodName => \SOAP::Data->value(
    SOAP::Data->name('LocationCriteria' => \SOAP::Data->value(
        SoapData('LocationName'),
        SoapData('LocationType')
    )),
    SOAP::Data->name('ObjectCriteria' => @ObjectCriteria),
    SOAP::Data->name('InputData' => \SOAP::Data->value(
            SOAP::Data->name('ObjectData' => \SOAP::Data->value(
                    SOAP::Data->type('xml' => $params{'ObjectData'})
            )),
    )),
    SOAP::Data->type('xml' => $processParmsXml )
));

$[/myPlugin/project/ec_perl_code_block_2]
