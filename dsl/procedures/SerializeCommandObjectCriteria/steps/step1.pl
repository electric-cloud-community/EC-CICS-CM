$[/myPlugin/project/ec_perl_header]

# Procedure-specific Metadata
# ---------------------------

my $soapMethodName;

# List of the names of optional paramters
my @optionalParams = (
    'ObjGroup',
    'ObjDefVer',
    'TContainer',
    'ObjectCriteria'
);

$[/myPlugin/project/ec_perl_metadata]

$[/myPlugin/project/ec_perl_code_block_1]

# Procedure-specific Code
# -----------------------

# Validation

# Validate ObjGroup and ObjDefVer in context of ObjType
if(($params{'ObjType'} eq 'RESGROUP') || ($params{'ObjType'} eq 'RESDESC')) {
    if (length($params{'ObjGroup'}) > 0) {
        print "ERROR: You cannot specify an Object Group when the Object Type is 'ResGroup (Group for CSD)' or 'ResDesc (List for CSD)'!\n";
        exit -1;
    }
} else {
    if ((length($params{'ObjGroup'}) > 0) && (length($params{'ObjDefVer'}) > 0)) {
        print "ERROR: You cannot specify both an Object Group and an Object Definition Version!\n";
        exit -1;
    } elsif (!(length($params{'ObjGroup'}) > 0) && !(length($params{'ObjDefVer'}) > 0)) {
        print "ERROR: For objects of type \'$params{'ObjType'}\', you must specify either an Object Group value or an Object Definition Version value!\n";
        exit -1;
    }
}    

# Validate TContainer in the context of Command
if(($params{'Command'} ne 'Add') and (length($params{'TContainer'}) > 0)) {
    print "ERROR: 'Target Resource Group For Add' is relevant only when packaging an Add command. It identifies the Resource Group to which you want the resource definitions added.";
    exit -1;
}

# Build @ObjectCriteria
my @mParams = ('Command', 'ObjGroup', 'ObjName', 'ObjType', 'ObjDefVer', 'TContainer');
my @ObjectCriteria = createObjectCriteria(\@mParams, 0, "CmdAPost", \%params, 1);

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

