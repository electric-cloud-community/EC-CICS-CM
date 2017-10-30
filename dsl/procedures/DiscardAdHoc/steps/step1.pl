$[/myPlugin/project/ec_perl_header]

# Procedure-specific Metadata
# ---------------------------

# Name of SOAP method to call
my $soapMethodName = 'Discard';

# List of the names of optional paramters
my @optionalParams = (
    'ObjectCriteria',
    'Quiesce',
    'QualificationData',
    'Connections',
    'ConnectionNames',
    'TargetScope'
);

$[/myPlugin/project/ec_perl_metadata]

$[/myPlugin/project/ec_perl_code_block_1]

# Procedure-specific Code
# -----------------------

# Build @ObjectCriteria
my @ObjectCriteria;
if ($params{'ObjectCriteria'}.length == 0) {
    
    # No ObjectCriteria, so we only have one element, and can ommit the <ListCount> and <ListElement>
    @ObjectCriteria = SOAP::Data->name('ObjectCriteria' => \SOAP::Data->value(
        SoapData('ObjName'),
        SoapData('ObjGroup'),
        SoapData('ObjType'),
    ));
} else {

    # Combine ObjName, ObjGroup, ObjType, and ObjectCriteria into @ObjectCriteria
    my $objectCriteria = $params{'ObjectCriteria'};
    #### TODO Confirm $objectCriteria is a valid XML fragment matching the expected schema
    my @matches = $objectCriteria =~ m/<ObjectData>/si;
    my $listCount = 1 + @matches;
    @ObjectCriteria = SOAP::Data->name('ObjectCriteria' => \SOAP::Data->value(
        SOAP::Data->name('ListCount' => $listCount),
        SOAP::Data->name('ListElement' => \SOAP::Data->value(
            SoapData('ObjName'),
            SoapData('ObjGroup'),
            SoapData('ObjType')
        )),
        SOAP::Data->type('xml' => $objectCriteria)
    ));    
}

# Build @CSDParams

# Check connections 
my $connections = $params{'connections'};
my @CSDParams;
if ($connections ne 'Named') {
    @CSDParams = SOAP::Data->name('ConnectionCount' => $connections);
}
else {
    # Split, count, and build XML from connectionNames
    my $connectionNames = $params{'connectionNames'};
    my @names = split($connectionNames, /\s+/);
    my $connectionCount = 0;
    foreach my $name (@names) {
        $connectionCount++ if ($name.length > 0);
    }
    if ($connectionCount == 0) {
        print "WARNING: Connections was set to 'Named', but no Connection Names were supplied!";
        exit(-1);
    }
    @CSDParams = SOAP::Data->name('ConnectionCount' => $connectionCount);
    foreach my $name (@names) {
        if ($name.length > 0) {
            push(@CSDParams, SOAP::Data->name('ConnectionElement' => \SOAP::Data->value(
                SOAP::Data->name('ConnectionName' => $name)
            )));
        }
    }
}

# Deal with optional parameters and build output

my @data = SOAP::Data->name($soapMethodName => \SOAP::Data->value(
    SOAP::Data->name('LocationCriteria' => \SOAP::Data->value(
        SoapData('LocationName'),
        SoapData('LocationType')
    )),
    SOAP::Data->name('ObjectCriteria' => @ObjectCriteria),
    SOAP::Data->name('ProcessParams' => \SOAP::Data->value(
$[/javascript (('' + myParent.Quiesce).length == 0) ? "" :
"        SoapData('Quiesce'),  # Optional parameter "
]
$[/javascript (('' + myParent.QualificationData).length == 0) ? "" :
"        SoapData('QualificationData'),  # Optional parameter "
]
$[/javascript (('' + myParent.Connections).length == 0) ? "" :
"        SOAP::Data->name('CSDParams' => @CSDParams),  # Optional section "
]
$[/javascript (('' + myParent.TargetScope).length == 0) ? "" :
"        SOAP::Data->name('CPSMParams' => \SOAP::Data->value( " +
"            SoapData('TargetScope'),  # Optional parameter " +
"        )), "
]
    )),
));

$[/myPlugin/project/ec_perl_code_block_2]
