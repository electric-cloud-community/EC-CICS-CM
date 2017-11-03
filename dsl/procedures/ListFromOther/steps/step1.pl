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

my @ObjectCriteria;
if (length $params{'ObjectCriteria'} == 0) {

    # No ObjectCriteria, so we only have one element, and can ommit the <ListCount> and <ListElement>
    @ObjectCriteria = SOAP::Data->name('ObjectCriteria' => \SOAP::Data->value(
        SoapData('ObjName'),
        $[/javascript (('' + myParent.ObjGroup).length == 0) ? "" :
                        "        SoapData('ObjGroup'),  # Optional parameter "
                        ],
                SoapData('ObjType'),
        $[/javascript (('' + myParent.ObjDefVer).length == 0) ? "" :
                        "        SoapData('ObjDefVer'),  # Optional parameter "
                        ],
        ));
} else {

    # Combine ObjName, ObjGroup, ObjType, and ObjectCriteria into @ObjectCriteria
        my $objectCriteria = $params{'ObjectCriteria'};
    my @matches = $objectCriteria =~ m/<ListElement>/si;
    my $listCount = 1 + @matches;
        @ObjectCriteria = SOAP::Data->name('ObjectCriteria' => \SOAP::Data->value(
            SOAP::Data->name('ListCount' => $listCount),
            SOAP::Data->name('ListElement' => \SOAP::Data->value(
                    SoapData('ObjName'),
        $[/javascript (('' + myParent.ObjGroup).length == 0) ? "" :
                                "        SoapData('ObjGroup'),  # Optional parameter "
                                ],
                        SoapData('ObjType'),
        $[/javascript (('' + myParent.ObjDefVer).length == 0) ? "" :
                                "        SoapData('ObjDefVer'),  # Optional parameter "
                                ],
                )),
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

# Deal with optional parameters and build output
my @data = SOAP::Data->name($soapMethodName => \SOAP::Data->value(
    SOAP::Data->name('LocationCriteria' => \SOAP::Data->value(
        SoapData('LocationName'),
        SoapData('LocationType')
    )),
    SOAP::Data->name('ObjectCriteria' => @ObjectCriteria),
$[/javascript ((('' + myParent.RestrictionCriteria).length == 0) || !(new RegExp("[^\.\s]+\.[^\.\s]+\.[^\.\s]+").test(myParent.RestrictionCriteria))) ? "" : // Check for presence of the pattern we parse
"    @restrictionCriteria,  # Optional section "
],
    SOAP::Data->type('xml' => $processParmsXml )
));

$[/myPlugin/project/ec_perl_code_block_2]
