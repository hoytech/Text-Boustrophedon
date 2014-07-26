use 5.010;
use strict;

use ExtUtils::MakeMaker;


my %args = (
    NAME => 'Text::Boustrophedon',
    VERSION_FROM => 'lib/Text/Boustrophedon.pm',
    PREREQ_PM => {
      'Text::WrapI18N' => 0,
    },
    LIBS => [],
    DEFINE => '',
    LICENSE => 'perl',
    dist => {
      PREOP => 'pod2text $(VERSION_FROM) > $(DISTVNAME)/README',
    },
    MIN_PERL_VERSION  => '5.10.0',
);


my $eummv = eval ($ExtUtils::MakeMaker::VERSION);
if ($eummv >= 6.45) {
    $args{META_MERGE} = {
        resources => {
            repository => 'git://github.com/hoytech/Text-Boustrophedon.git',
            bugtracker => 'https://github.com/hoytech/Text-Boustrophedon/issues',
        },
    };
}

WriteMakefile(%args);
