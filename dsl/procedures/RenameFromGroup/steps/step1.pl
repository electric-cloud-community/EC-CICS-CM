$[/myPlugin/project/ec_perl_header]

# Procedure-specific Metadata
# ---------------------------

# Name of SOAP method to call
my $soapMethodName = 'Remove';

# List of the names of optional paramters
my @optionalParams = (
    'Replace'
);

$[/myPlugin/project/ec_perl_metadata]

$[/myPlugin/project/ec_perl_code_block_1]


# Procedure-specific Code
# -----------------------

# Validate wildcards are at end
if ($params{'SourceName'} =~ /\*.+$/) {
    print "ERROR: The wildcard character '*' must only occur at the end of the Source Name!\n";
    exit -1;
}

# Handle optional Process Parameter
my @processParmsResult;
if (length($params{'Replace'}) > 0) {
    push @processParmsResult, SoapData($param);
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
    SOAP::Data->name('ObjectCriteria' => \SOAP::Data->value(
        SoapData('ObjName'),
        SoapData('ObjType'),
    )),
    SOAP::Data->name('InputData' => \SOAP::Data->value(
        SoapData('SourceName'),
        SoapData('SourceType'),
        SoapData('TargetGroup')
    )),
    @ProcessParms
));

$[/myPlugin/project/ec_perl_code_block_2]
