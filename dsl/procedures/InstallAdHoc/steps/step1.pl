$[/myPlugin/project/ec_perl_header]

# Procedure-specific Metadata
# ---------------------------

# Name of SOAP method to call
my $soapMethodName = 'Install';

# List of the names of optional paramters
my @optionalParams = (
    'ObjectCriteria',
    'Quiesce',
    'QualificationData',
    'Discard',
    'connections',
    'connectionNames',
    'Force',
    'TargetScope',
    'ResGroupObjectType',
    'CONNDEF_RefAssign',
    'FILEDEF_RelatedScope',
    'FILEDEF_Usage',
    'PROGDEF_RelatedScope',
    'PROGDEF_Usage',
    'PROGDEF_Mode',
    'TDQDEF_RelatedScope',
    'TDQDEF_Usage',
    'TDQDEF_Mode',
    'TRANDEF_RelatedScope',
    'TRANDEF_Usage',
    'TRANDEF_Mode'
);

$[/myPlugin/project/ec_perl_metadata]

$[/myPlugin/project/ec_perl_code_block_1]

# Procedure-specific Code
# -----------------------

# Build @ObjectCriteria
my @mParams = ('ObjName', 'ObjType', 'ObjGroup');
my @ObjectCriteria = createObjectCriteria(\@mParams, 0, "", \%params, 1);

# Build @CSDParms

# Check connections 
my $connections = $params{'connections'};
my @CSDParmsResult;
if ($connections ne 'Named') {
    @CSDParmsResult = SOAP::Data->name('ConnectionCount' => $connections);
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
    @CSDParmsResult = SOAP::Data->name('ConnectionCount' => $connectionCount);
    foreach my $name (@names) {
        if (length $name > 0) {
            push(@CSDParmsResult, SOAP::Data->name('ConnectionElement' => \SOAP::Data->value(
                SOAP::Data->name('ConnectionName' => $name)
            )));
        }
    }
}
@CSDParmsResult = SOAP::Data->name('CSDParms' => \SOAP::Data->value(@CSDParmsResult));

sub createSoap {
    my($wrapper, $parameters, $intrinsic) = @_;
    my @param;
    my @result;

    my @parameters = @{$parameters};
    my @intrinsic;
    if($intrinsic) {
        @intrinsic = @{$intrinsic};
    }

    for my $p (@parameters) {
        if (defined $params{$p} && $params{$p} ne "") {
            my @realName = split(/\_/, $p);
            if(scalar(@realName) > 1) {
                push @param, SOAP::Data->name( "$realName[1]" => $params{$p} );
            }
            else {
                push @param, SoapData($p);
            }
        }
    }
    if(@intrinsic and scalar(@intrinsic) > 0) {
        push @param , @intrinsic;
    }
    if (scalar(@param) > 0) {
        unshift @result, SOAP::Data->name( $wrapper => \SOAP::Data->value( @param ) );
    }
    return @result;
}

my @TRANDEF = ('TRANDEF_RelatedScope', 'TRANDEF_Usage', 'TRANDEF_Mode');
my @TRANDEFResult = createSoap("TRANDEF", \@TRANDEF);

my @TDQDEF = ('TDQDEF_RelatedScope', 'TDQDEF_Usage', 'TDQDEF_Mode');
my @TDQDEFResult = createSoap("TDQDEF", \@TDQDEF);

my @CONNDEF = ('CONNDEF_RefAssign');
my @CONNDEFResult = createSoap("CONNDEF", \@CONNDEF);

my @FILEDEF = ('FILEDEF_RelatedScope', 'FILEDEF_Usage');
my @FILEDEFResult = createSoap("FILEDEF", \@FILEDEF);

my @PROGDEF = ('PROGDEF_RelatedScope', 'PROGDEF_Usage', 'PROGDEF_Mode');
my @PROGDEFResult = createSoap("PROGDEF", \@PROGDEF);

my @CPSMParms = ('TargetScope', 'ResGroupObjectType');

my @result1 = (@TRANDEFResult, @TDQDEFResult, @CONNDEFResult, @FILEDEFResult, @PROGDEFResult);
my @CPSMParmsResult = createSoap("CPSMParms", \@CPSMParms, \@result1);

my @ProcessParms = ('Quiesce', 'QualificationData', 'Discard', 'Force');
my @result2 = (@CSDParmsResult, @CPSMParmsResult);
my @ProcessParmsResult = createSoap("ProcessParms", \@ProcessParms, \@result2);

my @data =
    SOAP::Data->name($soapMethodName => \SOAP::Data->value(
        SOAP::Data->name('LocationCriteria' => \SOAP::Data->value(
            SoapData('LocationName'),
            SoapData('LocationType')
        )),
        @ObjectCriteria,
        @ProcessParmsResult
    ));

$[/myPlugin/project/ec_perl_code_block_2]
