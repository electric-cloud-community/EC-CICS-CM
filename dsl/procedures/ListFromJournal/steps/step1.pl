$[/myPlugin/project/ec_perl_header]

# Procedure-specific Metadata
# ---------------------------

# Name of SOAP method to call
my $soapMethodName = 'List';

# List of the names of optional paramters
my @optionalParams = (
    'HashingScope',
    'ObjectHistory',
    'CPIDFormula',
    'Counts',
    'FilterDate',
    'Limit'
    'JnlCCVRel',
    'JnlCICSRel',
    'JnlCPID',
    'JnlScheme',
    'JnlUserID',
    'JnlObjGroup',
    'JnlObjName',
    'JnlObjType',
    'JnlCSD',
    'JnlContext'
);

$[/myPlugin/project/ec_perl_metadata]

$[/myPlugin/project/ec_perl_code_block_1]

# Procedure-specific Code
# -----------------------

# Split and parse optional RestrictionCriteria
my @restrictionCriteria = makeRestrictionCriteria($params{'RestrictionCriteria'});

my @objCriteriaResult;
my @objCriteriaParams = ('ObjName', 'ObjGroup', 'ObjDefVer');
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
my @processParmsParameters = ('HashingScope', 'ObjectHistory', 'CPIDFormula', 'Counts', 'FilterDate', 'Limit');
for my $p (@processParmsParameters) {
    if ($params{$p} ne "") {
        push @paramsForRequest, SoapData($p);
    }
}
if(scalar(@paramsForRequest) > 0) {
    push @paramsForRequestResult, SOAP::Data->name('ProcessParms' => \SOAP::Data->value(@paramsForRequest));
}

# Handle Journal parameters
my @jnlCriteriaParamsForRequest;
my @jnlCriteriaParamsForRequestResult;
my @jnlCriteriaParams = ('JnlCCVRel', 'JnlCICSRel', 'JnlCPID', 'JnlScheme', 'JnlUserID', 'JnlObjGroup', 'JnlObjName', 'JnlObjType', 'JnlCSD', 'JnlContext');
for my $p (@jnlCriteriaParams) {
    if ($params{$p} ne "") {
        push @jnlCriteriaParamsForRequest, SoapData($p);
    }
}
if(scalar(@jnlCriteriaParamsForRequest) > 0) {
    push  @jnlCriteriaParamsForRequestResult, SOAP::Data->name('JnlCriteria' => \SOAP::Data->value(@jnlCriteriaParamsForRequest));
}

my @data =
    SOAP::Data->name($soapMethodName => \SOAP::Data->value(
        SOAP::Data->name('LocationCriteria' => \SOAP::Data->value(
            SoapData('LocationName'),
            SoapData('LocationType')
        )),
        @jnlCriteriaParamsForRequestResult,
        SOAP::Data->name('ObjectCriteria' => @ObjectCriteria),
$[/javascript ((('' + myParent.RestrictionCriteria).length == 0) || !(new RegExp("[^\.\s]+\.[^\.\s]+\.[^\.\s]+").test(myParent.RestrictionCriteria))) ? "" : // Check for presence of the pattern we parse
"        @restrictionCriteria,  # Optional section "
]
        @paramsForRequestResult
    ));

$[/myPlugin/project/ec_perl_code_block_2]
