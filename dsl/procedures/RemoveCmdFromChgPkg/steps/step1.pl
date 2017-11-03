$[/myPlugin/project/ec_perl_header]

# Procedure-specific Metadata
# ---------------------------

# Name of SOAP method to call
my $soapMethodName = 'Remove';

# List of the names of optional paramters
my @optionalParams = (
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
my @ObjectCriteria;
if (length $params{'ObjectCriteria'} == 0) {

    # No ObjectCriteria, so we only have one element, and can ommit the <ListCount> and <ListElement>
    @ObjectCriteria = SOAP::Data->name('ObjectCriteria' => \SOAP::Data->value(
            SoapData('CConfig'),
            SOAP::Data->name('CmdAPost' => \SOAP::Data->value(
                    SoapData('Command'),
                    SoapData('ObjGroup'),
                    SoapData('ObjType'),
                    SoapData('ObjName'),
                    $[/javascript (('' + myParent.ObjDefVer).length == 0) ? "" :
                        "        SoapData('ObjDefVer'),  # Optional parameter "
                    ],
                    $[/javascript (('' + myParent.TContainer).length == 0) ? "" :
                        "        SoapData('TContainer'),  # Optional parameter "
                    ]
                ))
        ));
} else {

    # Combine ObjName, ObjGroup, ObjType, and ObjectCriteria into @ObjectCriteria
    my $objectCriteria = $params{'ObjectCriteria'};
    my @matches = $objectCriteria =~ m/<ListElement>/si;
    my $listCount = 1 + @matches;
    @ObjectCriteria = SOAP::Data->name('ObjectCriteria' => \SOAP::Data->value(
            SoapData('CConfig'),
            SOAP::Data->name('ListCount' => $listCount),
            SOAP::Data->name('ListElement' => \SOAP::Data->value(
                    SOAP::Data->name('CmdAPost' => \SOAP::Data->value(
                        SoapData('Command'),
                        SoapData('ObjGroup'),
                        SoapData('ObjType'),
                        SoapData('ObjName'),
                        $[/javascript (('' + myParent.ObjDefVer).length == 0) ? "" :
                                        "        SoapData('ObjDefVer'),  # Optional parameter "
                        ],
                        $[/javascript (('' + myParent.TContainer).length == 0) ? "" :
                                        "        SoapData('TContainer'),  # Optional parameter "
                        ]
                    ))
                )),
            SOAP::Data->type('xml' => $objectCriteria)
        ));
}

my @data =
SOAP::Data->name($soapMethodName => \SOAP::Data->value(
    SOAP::Data->name('LocationCriteria' => \SOAP::Data->value(
        SoapData('LocationType')
    )),
    @ObjectCriteria,
    SOAP::Data->name('InputData' => \SOAP::Data->value(
        SoapData('ContainerName'),
        SoapData('ContainerType')
    ))
));

$[/myPlugin/project/ec_perl_code_block_2]
