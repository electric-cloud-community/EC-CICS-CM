$[/myPlugin/project/ec_perl_header]

# Procedure-specific Metadata
# ---------------------------

# Name of SOAP method to call
my $soapMethodName = 'List';

# List of the names of optional paramters
my @optionalParams = ( #### TODO RestrictionCriteria, ObjectCriteria, ObjGroup, ObjeDefVer are all optional, and should be listed here so that the validastion code in ec_perl_code_block_1 knows that they are optional
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

my @mParams = ('ObjName', 'ObjGroup', 'ObjDefVer', 'ObjType', 'ObjDefVer'); #### TODO Why is 'ObjDefVer' listed twice?
my @ObjectCriteria = createObjectCriteria(\@mParams, 0, "", %params);

# Handle optional parameters
my @paramsForRequest;
for my $p (@optionalParams) { #### TODO this code should not assume that all optional parameters go into @paramsForRequest -- it should know what goes in, perhaps using a separate list
    if ($params{$p} ne "") {
        push @paramsForRequest, "<$p>$params{$p}</$p>"; #### TODO These should be built using SOAP::Data
    }
}
if(scalar(@paramsForRequest) > 0) {
    unshift @paramsForRequest, "<ProcessParms>"; #### TODO These should be built using SOAP::Data
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
"        @restrictionCriteria,  # Optional section "
],
        SOAP::Data->type('xml' => $processParmsXml ) #### TODO Switch this to building in the usual way from a SOAP::Data datstructure rather than raw XML
    ));

$[/myPlugin/project/ec_perl_code_block_2]
