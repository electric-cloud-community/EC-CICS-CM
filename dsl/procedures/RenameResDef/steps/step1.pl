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


# Procedure-specific Code
# -----------------------

# Build @ObjectCriteria

my @mParams = ('ObjName', 'ObjGroup', 'ObjType');
my @ObjectCriteria = createObjectCriteria(\@mParams, 0, "", \%params);

my @ObjectData;
if (length($params{'ObjectData'}) == 0) {
    print "ERROR: Input Data Name-Value Pairs missing!";
    exit -1;
} else {
    # Build @ObjectData
    my @parts = split(/\s+/s, $params{'ObjectData'}); # Split at whitesapece (including line breaks)
    push(@ObjectData, SOAP::Data->name('TargetCount' => scalar(@parts)));
    foreach my $part (@parts) {
        my @pieces = split(/,/, $part, 2); # Split at first ',' into name and value
        if (@pieces == 2) {
            my @targetElement = SOAP::Data->name('TargetElement' => \SOAP::Data->value(
                SOAP::Data->name('TargetName' => $pieces[0]),
                SOAP::Data->name('TargetGroup' => $pieces[1]),
            ));
            push(@ObjectData, @targetElement);
        } else {
            print "ERROR: Unable to parse Object Data Name-Value Pairs near '$part'!";
            exit -1;
        }
    }
}

my @data =
SOAP::Data->name($soapMethodName => \SOAP::Data->value(
    SOAP::Data->name('LocationCriteria' => \SOAP::Data->value(
        SoapData('LocationName'),
        SoapData('LocationType')
    )),
    SOAP::Data->name('ObjectCriteria' => \SOAP::Data->value(
        SOAP::Data->name('ObjectCriteria' => @ObjectCriteria),
    )),
    SOAP::Data->name('InputData' => \SOAP::Data->value(
        @ObjectData
    )),
    SOAP::Data->name('ProcessParms' => \SOAP::Data->value(
        SoapData('Replace')
    ))
));

$[/myPlugin/project/ec_perl_code_block_2]
