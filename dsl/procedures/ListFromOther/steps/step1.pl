$[/myPlugin/project/ec_perl_header]

# Procedure-specific Metadata
# ---------------------------

# Name of SOAP method to call
my $soapMethodName = 'List';

# List of the names of optional paramters
my @optionalParams = (
    'ObjGroup', 'ObjDefVer', 'RestrictionCriteria'
);

$[/myPlugin/project/ec_perl_metadata]

$[/myPlugin/project/ec_perl_code_block_1]

# Procedure-specific Code
# -----------------------

# Check for invalid combinations of optional parameters
if (length($params{'ObjDefVer'}) > 0 ) {
   if ($params{'LocationType'} ne 'Context') {
       print "ERROR: You cannot specify a Resource Definition Version value unless the Location Type is 'Context'!";
       exit -1;
   }
   if (length($params{'ObjGroup'}) > 0) {
       print "ERROR: You cannot specify both a Resource Definition Version value and a Resource Group value!";
       exit -1;
   }
}
   
# Split and parse optional RestrictionCriteria

my @RestrictionCriteria;
if (length($params{'RestrictionCriteria'}) > 0) {

    # First go through and collect all the counts
    my $restrictionCount = 0;
    my %listCount;
    my @lines = split(/$/, $params{'RestrictionCriteria'}); # Split into lines
    foreach my $line (@lines) {
        $listCount{$line} = 0;
        my @parts = split(/\s+/, $line); # Split on whitespace
        foreach my $part (@parts) {
            my @pieces = split(/\./, $part, 3); # Split at first two .'s into field, operator, and value
            if (@pieces == 3) {
                $listCount{$line}++;
            }
        }
        if ($listCount{$line} > 0) {
            $restrictionCount++;
        }
    }

    if ($restrictionCount > 0) {
    
        # Now we have counts, go through again and build the actual output
        push(@RestrictionCriteria, SOAP::Data->name('RestrictionCount' => $restrictionCount));
        foreach my $line (@lines) {
            if ($listCount{$line} > 0) {
                my @RestrictionElement;
                push(@RestrictionElement, SOAP::Data->name('ListCount' => $listCount{$line}));
                my @parts = split(/\s+/, $line); # Split on whitespace
                foreach my $part (@parts) {
                    my @pieces = split(/\./, $part, 3); # Split at first two .'s into field, operator, and value
                    if (@pieces == 3) {
                        push(@RestrictionElement, SOAP::Data->name('ListElement' => \SOAP::Data->value(
                            SOAP::Data->name('RestrictionField' => $pieces[0]),              
                            SOAP::Data->name('RestrictionOperator' => $pieces[1]),              
                            SOAP::Data->name('RestrictionValue' => $pieces[2])
                        )));
                    }
                }
                push(@RestrictionCriteria, SOAP::Data->name('RestrictionElement' => \SOAP::Data->value(@RestrictionElement)));
            }            
        }
    }
}

# Deal with optional parameters and build output

my @ObjectCriteria = (
    SoapData('ObjType'),
    SoapData('ObjName')
);
push(@ObjectCriteria, SoapData('ObjGroup')) if (length($params{'ObjGroup'}) > 0);
push(@ObjectCriteria, SoapData('ObjDefVer')) if (length($params{'ObjDefVer'}) > 0);

my @methodTags = (
    SOAP::Data->name('LocationCriteria' => \SOAP::Data->value(
        SoapData('LocationName'),
        SoapData('LocationType')
    )),
    SOAP::Data->name('ObjectCriteria' => \SOAP::Data->value(
	@ObjectCriteria
    ))
);
push(@methodTags, SOAP::Data->name('RestrictionCriteria' => \SOAP::Data->value(@RestrictionCriteria))) if (@RestrictionCriteria > 0);
#### TODO Add the optional ProcessParms here and to form.xml
 
my @data = SOAP::Data->name($soapMethodName => \SOAP::Data->value(@methodTags));

$[/myPlugin/project/ec_perl_code_block_2]
