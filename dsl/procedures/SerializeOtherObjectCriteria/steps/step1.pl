$[/myPlugin/project/ec_perl_header]

# Procedure-specific Metadata
# ---------------------------

my $soapMethodName;

# List of the names of optional paramters
my @optionalParams = (
    'ObjectCriteria',
    'ObjGroup',
    'ObjDefVer',
    'ObjectInstance'
);

$[/myPlugin/project/ec_perl_metadata]

$[/myPlugin/project/ec_perl_code_block_1]

# Procedure-specific Code
# -----------------------

# Universal validation

# Validate Object Group against Object Type
if(($params{'ObjType'} eq 'RESGROUP') || ($params{'ObjType'} eq 'RESDESC')) {
    if (length($params{'ObjGroup'}) > 0) {
        print "ERROR: You cannot specify a Resource Group when the Resource Type is 'ResGroup (Group for CSD)' or 'ResDesc (List for CSD)'!\n";
        exit -1;
    }
}

# Validate Object Group against Object Definition Version
if ((length($params{'ObjGroup'}) > 0) && (length($params{'ObjDefVer'}) > 0)) {
    print "ERROR: You cannot specify both a Resource Group and a Resource Definition Version!\n";
    exit -1;
}

# Procedure-specific validation

my $procedure = $params{'procedure'};

# ObjectInstance is only allowed for the Recover procedure
if ($procedure ne 'Recover') {
    if (length($params{'ObjectInstance'}) > 0) {
        print "ERROR: You cannot specify a Resource Instance value when building Object Criteria for use with the $procedure procedure!\n";
        exit -1;
    }
}

# Validate Object Type against procedure
if (($procedure eq 'AddResDefToChgPkg') || ($procedure eq 'RemoveDefFromChgPkg')) {
    if ($params{'ObjType'} eq 'PLATDEF') {
        print "ERROR: The Resource Type 'PlatDef' cannot be used when building Object Criteria for use with the $procedure procedure!\n";
        exit -1;
    } elsif ($params{'ObjType'} eq 'RESGROUP') {
        print "ERROR: The Resource Type 'ResGroup (Group for CSD)' cannot be used when building Object Criteria for use with the $procedure procedure!\n";
        exit -1;
    } elsif ($params{'ObjType'} eq 'RESDESC') {
        print "ERROR: The Resource Type 'ResDesc (List for CSD)' cannot be used when building Object Criteria for use with the $procedure procedure!\n";
        exit -1;
    }
} elsif (($procedure eq 'AddToResGrp') || ($procedure eq 'RemoveFromResGrp') || ($procedure eq 'RenameResDef')) {
    if ($params{'ObjType'} eq 'RESGROUP') {
        print "ERROR: The Resource Type 'ResGroup (Group for CSD)' cannot be used when building Object Criteria for use with the $procedure procedure!\n";
        exit -1;
    } elsif ($params{'ObjType'} eq 'RESDESC') {
        print "ERROR: The Resource Type 'ResDesc (List for CSD)' cannot be used when building Object Criteria for use with the $procedure procedure!\n";
        exit -1;
    }
} elsif ($procedure eq 'Copy') {  
    #### TODO Find out if this is correct
    if ($params{'ObjType'} eq 'RESGROUP') {
        print "ERROR: The Resource Type 'ResGroup (Group for CSD)' cannot be used when building Object Criteria for use with the $procedure procedure!\n";
        exit -1;
    } elsif ($params{'ObjType'} eq 'RESDESC') {
        print "ERROR: The Resource Type 'ResDesc (List for CSD)' cannot be used when building Object Criteria for use with the $procedure procedure!\n";
        exit -1;
    }
} elsif (($procedure eq 'AddToResDesc') || ($procedure eq 'RemoveFromResDesc')) {
    if ($params{'ObjType'} ne 'RESGROUP') {
        print "ERROR: The only Resource Type value allowed is 'ResGroup (Group for CSD)' when building Object Criteria for use with the $procedure procedure!\n";
        exit -1;
    }
} elsif ($procedure eq 'NewcopyAdHoc') {
    if (($params{'ObjType'} ne 'MAPDEF') && ($params{'ObjType'} ne 'PROGDEF') && ($params{'ObjType'} ne 'PRTNDEF') && ($params{'ObjType'} ne 'DOCDEF')){
        print "ERROR: The only Resource Type values allowed are 'MapDef', 'ProgDef', 'PrtnDef' and 'DocDef' when building Object Criteria for use with the $procedure procedure!\n";
        exit -1;
    }
}

#### TODO Add procedure-specific validation, some inside if ($procedure ne ...) and some in a big switch dependant on $procedure
#### TODO Search all the candidate procedures for procedure-specific validation

my %tagName = (
    'AddResDefToChgPkg' => 'KeyA',
    'AddToResDesc' => 'GrpA',
    'AddToResGrp' => 'DefA',
    'RemoveFromResDesc' => 'GrpA',
    'RemoveFromResGrp' => 'DefA',
    'RemoveResDefFromChgPkg' => 'KeyA'
);
  
# Build @ObjectCriteria
my $tagName = $tagName{$procedure};
if ($tagName eq undef) {
    $tagName = "";
}
my @mParams = ('ObjGroup', 'ObjType', 'ObjName', 'ObjDefVer', 'ObjectInstance'); 
my @ObjectCriteria = createObjectCriteria(\@mParams, 0, $tagName, \%params, 1);

# Convert to XML
my $serializer = SOAP::Serializer->new();
$serializer->autotype(0);
$serializer->readable(1);
my $xml = $serializer->serialize(@ObjectCriteria);

# Remove unneeded leading/enclosing tags
$xml =~ s/^<\?xml [^?]*\?>\s*//s;
$xml =~ s/^<ObjectCriteria(?: xmlns:[^=]+="[^"]+")*\s*>\s*//s;
$xml =~ s/\s*<\/ObjectCriteria\s*>\s*$//s;
$xml =~ s/^<ListCount\s*>[0-9]+<\/ListCount\s*>\s*/  /s;

# Store the XML in the output property
$ec->setProperty($params{'outputProperty'}, {value => $xml});

