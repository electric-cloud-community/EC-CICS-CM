$[/myPlugin/project/ec_perl_header]

# Procedure-specific Metadata
# ---------------------------

# Name of SOAP method to call
my $soapMethodName = 'Newcopy';

# List of the names of optional paramters
my @optionalParams = (
    'ObjectCriteria',
    'PhaseIn',
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
my @mParams = ('ObjName', 'ObjType', 'ObjGroup');
my @ObjectCriteria = createObjectCriteria(\@mParams, 0, "", \%params, 1);

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
    my @names = split(/\s+/, $connectionNames);
    my $connectionCount = 0;
    foreach my $name (@names) {
        $connectionCount++ if (length $name > 0);
    }
    if ($connectionCount == 0) {
        print "WARNING: Connections was set to 'Named', but no Connection Names were supplied!";
        exit(-1);
    }
    @CSDParams = SOAP::Data->name('ConnectionCount' => $connectionCount);
    foreach my $name (@names) {
        if (length $name > 0) {
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
    SOAP::Data->name('ProcessParms' => \SOAP::Data->value(
$[/javascript (('' + myParent.PhaseIn).length == 0) ? "" :
"        SoapData('PhaseIn'),  # Optional parameter "
]
$[/javascript (('' + myParent.QualificationData).length == 0) ? "" :
"        SoapData('QualificationData'),  # Optional parameter "
]
$[/javascript (('' + myParent.Connections).length == 0) ? "" :
"        SOAP::Data->name('CSDParams' => \\SOAP::Data->value(@CSDParams)),  # Optional section "
]
$[/javascript (('' + myParent.TargetScope).length == 0) ? "" :
"        SOAP::Data->name('CPSMParams' => \SOAP::Data->value( \n" +
"            SoapData('TargetScope'),  # Optional parameter \n" +
"        )), "
]
    )),
));

$[/myPlugin/project/ec_perl_code_block_2]
