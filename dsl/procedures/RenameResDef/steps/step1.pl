$[/myPlugin/project/ec_perl_header]

# Procedure-specific Metadata
# ---------------------------

# Name of SOAP method to call
my $soapMethodName = 'Rename';

# List of the names of optional paramters
my @optionalParams = (
    'ObjectCriteria',
    'InputData',
    'Replace'
);

$[/myPlugin/project/ec_perl_metadata]

$[/myPlugin/project/ec_perl_code_block_1]


# Procedure-specific Code
# -----------------------

# Validate wildcards are at end
if (($params{'ObjName'} =~ /\*.+$/) || ($params{'ObjGroup'} =~ /\*.+$/)) {
    print "ERROR: The wildcard character '*' must only occur at the end of the Object Name or Object Group!\n";
    exit -1;
}

# Build @ObjectCriteria
my @mParams = ('ObjName', 'ObjGroup', 'ObjType');
my @ObjectCriteria = createObjectCriteria(\@mParams, 0, "", \%params);

# Build InputData and validate size against ObjectCriteria
my @InputData;
if (length($params{'InputData'}) == 0) {
    my @targetElement = SOAP::Data->name('TargetElement' => \SOAP::Data->value(
        SOAP::Data->name('TargetName' => $params{'TargetName'}),
        SOAP::Data->name('TargetGroup' => $params{'TargetGroup'}),
    ));
    push(@InputData, @targetElement);
    if (length($params{'ObjectCriteria'}) > 0) {
        print "ERROR: 'Serialized Resource Object Criteria' and 'Resource Name-Group Pairs' should contain the same number of elements!\n";
        exit -1;
    }
} else {
    # Build @InputData
    my $countID = 0;
    my @parts = split(/\s+/s, $params{'InputData'}); # Split at whitespace (including line breaks)
    push(@InputData, SOAP::Data->name('TargetCount' => 1 + scalar(@parts)));
    my @targetElement = SOAP::Data->name('TargetElement' => \SOAP::Data->value(
        SOAP::Data->name('TargetName' => $params{'TargetName'}),
        SOAP::Data->name('TargetGroup' => $params{'TargetGroup'}),
    ));
    push(@InputData, @targetElement);
    foreach my $part (@parts) {
        my @pieces = split(/\//, $part, 2); # Split at first / into name and value
        if (@pieces == 2) {
            @targetElement = SOAP::Data->name('TargetElement' => \SOAP::Data->value(
                SOAP::Data->name('TargetName' => $pieces[0]),
                SOAP::Data->name('TargetGroup' => $pieces[1]),
            ));
            push(@InputData, @targetElement);
            $countID++;
        } else {
            print "ERROR: Unable to parse Object Data Name-Value Pairs near '$part'!";
            exit -1;
        }
    }
    my @countOC = ($params{'ObjectCriteria'} =~ /<ListElement\s*>/);
    if ($countID != scalar(@countOC)) {
        print "ERROR: 'Serialized Resource Object Criteria' and 'Resource Name-Group Pairs' should contain the same number of elements!\n";
        exit -1;
    }
}

# Handle optional Process Parameter
my @processParmsResult;
if (length($params{'Replace'}) > 0) {
    push @processParmsResult, SoapData('Replace');
}
my @ProcessParms;
if(scalar(@processParmsResult) > 0) {
    @ProcessParms =
        SOAP::Data->name('ProcessParms' => \SOAP::Data->value(
            @processParmsResult
        ));
}

my @data =
SOAP::Data->name($soapMethodName => \SOAP::Data->value(
    SOAP::Data->name('LocationCriteria' => \SOAP::Data->value(
        SoapData('LocationName'),
        SoapData('LocationType')
    )),
    @ObjectCriteria,
    SOAP::Data->name('InputData' => \SOAP::Data->value(
        @InputData
    )),
    SOAP::Data->name('ProcessParms' => \SOAP::Data->value(
        SoapDataOptional('Replace')
    ))
));

$[/myPlugin/project/ec_perl_code_block_2]
