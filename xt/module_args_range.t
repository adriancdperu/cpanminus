use strict;
use Test::More;
use xt::Run;

my $local_lib = "$ENV{PERL_CPANM_HOME}/perl5";

# range for v-strings
run '--notest', "-L", $local_lib, 'App::ForkProve~>= v0.4.0, < v0.5.0';
like last_build_log, qr/installed forkprove-v0\.4\./;

run "-L", $local_lib, 'Try::Tiny~<0.12';
like last_build_log, qr/installed Try-Tiny-0\.11/;

run "-L", $local_lib, '--reinstall', 'Try::Tiny~>=0.08';
like last_build_log, qr/installed Try-Tiny/;
unlike last_build_log, qr/You have Try::Tiny/;

run "-L", $local_lib, 'Try::Tiny'; # pull latest from CPAN

run "-L", $local_lib, '--notest', 'Try::Tiny~<0.08,!=0.07';
like last_build_log, qr/installed Try-Tiny-0.06/;

run "-L", $local_lib, 'Try::Tiny~>0.06, <0.08,!=0.07';
like last_build_log, qr/Could not find a release .* on MetaCPAN/;
like last_build_log, qr/doesn't satisfy/;

done_testing;
