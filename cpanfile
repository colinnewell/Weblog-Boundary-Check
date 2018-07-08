requires "strictures" => "2";
requires "namespace::clean";
requires "Types::Standard";
requires "Moo";

on 'test' => sub {
  requires "ExtUtils::MakeMaker" => "0";
  requires "File::Spec" => "0";
  requires "Test2::V0" => "0";
  requires "strict" => "0";
  requires "warnings" => "0";
};

on 'test' => sub {
  recommends "CPAN::Meta" => "2.120900";
};

on 'configure' => sub {
  requires "ExtUtils::MakeMaker" => "0";
};

on 'develop' => sub {
  requires "File::Spec" => "0";
  requires "IO::Handle" => "0";
  requires "IPC::Open3" => "0";
  requires "Test2::V0" => "0";
  requires "Test::Pod" => "1.41";
  requires "blib" => "1.01";
  requires "perl" => "5.006";
  requires "strict" => "0";
  requires "warnings" => "0";
};
