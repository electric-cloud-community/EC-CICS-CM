$[/myPlugin/project/ec_perl_header]

# Procedure-specific Metadata
# ---------------------------

# Name of SOAP method to call
my $soapMethodName = 'Install';

# List of the names of optional paramters
my @optionalParams = (
);

$[/myPlugin/project/ec_perl_metadata]

$[/myPlugin/project/ec_perl_code_block_1]


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

# Procedure-specific Code
# -----------------------

# Build @ObjectCriteria
my @mParams = ('ObjName', 'ObjType', 'ObjGroup');
my @ObjectCriteria = createObjectCriteria(\@mParams, 0, "", %params);

# Build ConnectionElement
my $conElementStr = $params{'ConnectionElement'};
my @connectionElement;
my @parts = split(/\s+/s, $conElementStr); # Split at whitesapece (including line breaks)
if(length $params{'ConnectionElement'} > 0) {
    if(($params{'ConnectionCount'} eq "") and scalar(@parts) > 0) {
        push(@connectionElement, SOAP::Data->name('ConnectionName' => scalar(@parts)));
    }
    else {
        push(@connectionElement, SoapData('ConnectionCount'));
    }
}
foreach my $part (@parts) {
    push(@connectionElement, SOAP::Data->name('ConnectionElement' => \SOAP::Data->value(
                SOAP::Data->name('ConnectionName' => $part)))
            );
}

my @TRANDEF = ('TRANDEF_RelatedScope', 'TRANDEF_Usage', 'TRANDEF_Mode');
my @TRANDEF_result = createSoap("TRANDEF", \@TRANDEF);

my @TDQDEF = ('TDQDEF_RelatedScope', 'TDQDEF_Usage', 'TDQDEF_Mode');
my @TDQDEF_res = createSoap("TDQDEF", \@TDQDEF);

my @CONNDEF = ('CONNDEF_RefAssign');
my @CONNDEF_res = createSoap("CONNDEF", \@CONNDEF);

my @FILEDEF = ('FILEDEF_RelatedScope', 'FILEDEF_Usage');
my @FILEDEF_res = createSoap("FILEDEF", \@FILEDEF);

my @PROGDEF = ('PROGDEF_RelatedScope', 'PROGDEF_Usage', 'PROGDEF_Mode');
my @PROGDEF_res = createSoap("PROGDEF", \@PROGDEF);

my @CPSMParms = ('TargetScope', 'ResGroupObjectType');

my @result1 = (@TRANDEF_result, @TDQDEF_res, @CONNDEF_res, @FILEDEF_res, @PROGDEF_res);
my @CPSMParms_res = createSoap("CPSMParms", \@CPSMParms, \@result1);


my @CSDParms = ('');
my @CSDParms_res = createSoap("CSDParms", \@CSDParms, \@connectionElement);

my @ProcessParms = ('Quiesce', 'QualificationData', 'Discard', 'Force');
my @result2 = (@CSDParms_res, @CPSMParms_res);
my @ProcessParms_res = createSoap("PROGDEF", \@ProcessParms, \@result2);

my @data =
    SOAP::Data->name($soapMethodName => \SOAP::Data->value(
            SOAP::Data->name('LocationCriteria' => \SOAP::Data->value(
                    SoapData('LocationName'),
                    SoapData('LocationType')
                )),
            @ObjectCriteria,
            @ProcessParms_res
        ));

$[/myPlugin/project/ec_perl_code_block_2]
