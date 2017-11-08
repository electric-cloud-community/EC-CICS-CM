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
$[/myPlugin/project/ec_perl_metadata]

$[/myPlugin/project/ec_perl_code_block_1]

# Validation
#-----------------------------

my @objCriteriaResult;
my @objCriteriaParams = ('ObjType', 'ObjName'); #### TODO Why is ObjGroup not included?
for my $p (@objCriteriaParams) {
    if (defined $params{$p} && $params{$p} ne "") {
        push @objCriteriaResult, SoapData($p);
    }
}

# Procedure-specific Code
# -----------------------

# Build @ObjectCriteria
my @ObjectCriteria;
if ( $params{'ObjType'} && !$params{'ObjectCriteria'}) {

    # No ObjectCriteria, so we only have one element, and can ommit the <ListCount> and <ListElement>
    @ObjectCriteria = SOAP::Data->name('ObjectCriteria' => \SOAP::Data->value(
            @objCriteriaResult
        ));
} else {

    # Combine ObjName, ObjType, and ObjectCriteria into @ObjectCriteria
    my $objectCriteria = $params{'ObjectCriteria'};
    @ObjectCriteria = SOAP::Data->name('ObjectCriteria' => \SOAP::Data->value(
            @objCriteriaResult,
            SOAP::Data->type('xml' => $objectCriteria)
        ));
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
