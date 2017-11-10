$[/myPlugin/project/ec_perl_header]

# Procedure-specific Metadata
# ---------------------------

#### TODO This needs code review

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

$[/myPlugin/project/ec_perl_metadata]

$[/myPlugin/project/ec_perl_code_block_1]

# Procedure-specific Code
# -----------------------

# Split and parse optional RestrictionCriteria
my @restrictionCriteria = makeRestrictionCriteria($params{'RestrictionCriteria'});

my @mParams = ('ObjName', 'ObjGroup', 'ObjType', 'ObjDefVer');
my @ObjectCriteria = createObjectCriteria(\@mParams, 0, "", \%params);

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
$[/javascript ((('' + myParent.RestrictionCriteria).length == 0) || !(new RegExp("[^\.\s]+\.[^\.\s]+\.[^\.\s]+").test(myParent.RestrictionCriteria))) ? "" : // Check for presence of the pattern we parse
"           @restrictionCriteria,  # Optional section "
],
        SOAP::Data->type('xml' => $processParmsXml )
    ));

$[/myPlugin/project/ec_perl_code_block_2]
