use Digest::MD5 qw(md5_hex);
use Digest::MD5;

# Example to implement MD5
print "Digest is ", md5_hex("foobarbaz"), "\n";

# Another way to implement
$md5 = Digest::MD5->new;
$md5->add('foo', 'bar');
$md5->add('baz');
$digest = $md5->hexdigest;
print "Digest is $digest\n";

# MD5 on the contents of a file

#ls -lLR

my $v1Contents = `cat v1.txt`;
my $v1_0Contents = `cat v1_0.txt`;
my $v2Contents = `cat v2.txt`;

print "\n\n";
print "v1Contents = $v1Contents\n","MD5=",md5_hex($v1Contents),"\n\n";
print "v1_0Contents = $v1_0Contents\n","MD5=",md5_hex($v1_0Contents),"\n\n";
print "v2Contents = $v2Contents\n","MD5=",md5_hex($v2Contents),"\n\n";