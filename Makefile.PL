use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
	      'NAME'	=> 'Apache::HeavyCGI',
	      'VERSION_FROM' => 'lib/Apache/HeavyCGI.pm', # finds $VERSION
	      dist => {
		       PREOP => 'co -l README && pod2text lib/Apache/HeavyCGI.pm > README && ci -u README',
		      }
);

sub MY::test {
  my($self)=@_;
  qq{test:\n\t$self->{NOECHO}echo No automated tests available.
\t$self->{NOECHO}echo A simple minded test case is described in eg/README.
};
}
