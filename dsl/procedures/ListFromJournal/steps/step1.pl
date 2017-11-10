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
);

my @jnlCriteriaParams = ( #### TODO These are optional parameters but are not listed in @optionalParams -- however, the validation code in ec_perl_code_1 needs them to be (once we add validations for them)
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
for my $p (@optionalParams) { #### TODO This should not jst use @optionalParams, since that should also contain the contents of @jnlCriteriaParams
    if ($params{$p} ne "") {
        push @paramsForRequest, "<$p>$params{$p}</$p>";
    }
}
if(scalar(@paramsForRequest) > 0) {
    unshift @paramsForRequest, "<ProcessParms>";
    push @paramsForRequest, "</ProcessParms>";
}
my $processParmsXml = "@paramsForRequest";

# Handle Journal parameters
my @jnlCriteriaParamsForRequest;
for my $p (@jnlCriteriaParams) {
    if ($params{$p} ne "") {
        push @jnlCriteriaParamsForRequest, "<$p>$params{$p}</$p>";
    }
}
if(scalar(@jnlCriteriaParamsForRequest) > 0) {
    unshift @jnlCriteriaParamsForRequest, "<JnlCriteria>";
    push @jnlCriteriaParamsForRequest, "</JnlCriteria>";
}
my $jnlCriteriaXml = "@jnlCriteriaParamsForRequest";

my @data =
    SOAP::Data->name($soapMethodName => \SOAP::Data->value(
        SOAP::Data->name('LocationCriteria' => \SOAP::Data->value(
            SoapData('LocationName'),
            SoapData('LocationType')
        )),
        SOAP::Data->type('xml' => $jnlCriteriaXml ),
        SOAP::Data->name('ObjectCriteria' => @ObjectCriteria),
$[/javascript ((('' + myParent.RestrictionCriteria).length == 0) || !(new RegExp("[^\.\s]+\.[^\.\s]+\.[^\.\s]+").test(myParent.RestrictionCriteria))) ? "" : // Check for presence of the pattern we parse
"        @restrictionCriteria,  # Optional section "
]
        SOAP::Data->type('xml' => $processParmsXml )
    ));

$[/myPlugin/project/ec_perl_code_block_2]
