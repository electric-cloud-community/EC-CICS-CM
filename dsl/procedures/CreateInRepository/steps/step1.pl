$[/myPlugin/project/ec_perl_header]

# Procedure-specific Metadata
# ---------------------------

# Name of SOAP method to call
my $soapMethodName = 'Create';

# List of the names of optional paramters
my @optionalParams = (
#    'CPID',
#    'Scheme',

);
my @mandatoryParams = (
    'ObjectData',

);
$[/myPlugin/project/ec_perl_metadata]

$[/myPlugin/project/ec_perl_code_block_1]

# Validation
#-----------------------------

if(!$params{'ObjType'}  and !$params{'ObjectCriteria'}) {
    print "ERROR: Eeather 'ObjectCrireria' in xml or entry for 'ObjType' should be filled.";
    exit -1;
}

if(!$params{'ObjType'} and !contains(uc('ObjType'), uc($params{'ObjectCriteria'}))) {
    print "ERROR: 'ObjType' shoud be specifyed.";
    exit -1;
}

# Procedure-specific Code
# -----------------------

# Build @ObjectCriteria
my @ObjectCriteria;
if ( $params{'ObjType'}) {

    # No ObjectCriteria, so we only have one element, and can ommit the <ListCount> and <ListElement>
    @ObjectCriteria = SOAP::Data->name('ObjectCriteria' => \SOAP::Data->value(
            SoapData('ObjType'),
            SoapData('ObjName'),
        ));
} else {

    # Combine ObjName, ObjType, and ObjectCriteria into @ObjectCriteria
    my $objectCriteria = $params{'ObjectCriteria'};
    @ObjectCriteria = SOAP::Data->name('ObjectCriteria' => \SOAP::Data->value(
            SOAP::Data->type('xml' => $objectCriteria)
        ));
}

my @paramsForRequest;
for my $p (@optionalParams, @mandatoryParams) {
    if (defined $params{$p}) {
        push @paramsForRequest, SoapData($p);
    }
}

my @data =
SOAP::Data->name($soapMethodName => \SOAP::Data->value(
    SOAP::Data->name('LocationCriteria' => \SOAP::Data->value(
        SoapData('LocationType')
    )),
    SOAP::Data->name('ObjectCriteria' => @ObjectCriteria),
    SOAP::Data->name('InputData' => \SOAP::Data->value(
            SOAP::Data->name('ObjectData' => \SOAP::Data->value(
                    SOAP::Data->type('xml' => $params{'ObjectData'})
                )),
        ))
));
$[/myPlugin/project/ec_perl_code_block_2]
