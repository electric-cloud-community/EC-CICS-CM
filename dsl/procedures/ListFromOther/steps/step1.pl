$[/myPlugin/project/ec_perl_header]

# Procedure-specific Metadata
# ---------------------------

# Name of SOAP method to call
my $soapMethodName = 'List';

# List of the names of optional paramters
my @optionalParams = (
    'ObjGroup',
    'ObjDefVer',
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

# Check for invalid combinations of optional parameters
if (length($params{'ObjDefVer'}) > 0 ) {
   if ($params{'LocationType'} ne 'Context') {
       print "ERROR: You cannot specify a Resource Definition Version value unless the Location Type is 'Context'!";
       exit -1;
   }
   if (length($params{'ObjGroup'}) > 0) {
       print "ERROR: You cannot specify both a Resource Definition Version value and a Resource Group value!";
       exit -1;
   }
}
   
# Split and parse optional RestrictionCriteria
my @restrictionCriteria = makeRestrictionCriteria($params{'RestrictionCriteria'});

my @mParams = ('ObjName', 'ObjGroup', 'ObjDefVer', 'ObjType');
my @ObjectCriteria = createObjectCriteria(\@mParams, 0, "", \%params);

# Handle optional parametrs
my @paramsForRequest;
my @paramsForRequestResult;
my @paramsForRequestParams = ('HashingScope', 'ObjectHistory', 'CPIDFormula', 'Counts', 'FilterDate', 'Limit');
for my $p (@paramsForRequestParams) {
    if ($params{$p} ne "") {
        push @paramsForRequest, SoapData($p);
    }
}

if(scalar(@paramsForRequest) > 0) {
    push  @paramsForRequestResult, SOAP::Data->name('ProcessParms' => \SOAP::Data->value(@paramsForRequest));
}

# Deal with optional parameters and build output
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
        @paramsForRequestResult
    ));

$[/myPlugin/project/ec_perl_code_block_2]
