package t::Tools_loadPackage;
use base t::TestBase;
use strict;
use Test::More;
use Tools;

#------------------------------------------------------------------------
sub testPlan{
    my $self = shift;

    $self->LoadFakeModuleForMockifyTest();
    $self->LoadAllreadyLoadedModule();

    return;
}

#------------------------------------------------------------------------
sub LoadFakeModuleForMockifyTest {
    my $self = shift;
    my $SubTestName = (caller(0))[3];

    my $Tools = Tools->new();
    my $ModulePath = 't/FakeModuleForMockifyTest.pm';
    is($INC{$ModulePath}, undef ,"$SubTestName - check if the module is not loaded now - undef");
    $Tools->loadPackage('t::FakeModuleForMockifyTest');
    is( $INC{$ModulePath}, $ModulePath, "$SubTestName - the module: $ModulePath is loaded");
    delete $INC{$ModulePath};# rollback
    is($INC{$ModulePath}, undef ,"$SubTestName - check if the module is not loaded now (rollback was fine)- undef");

    return;
}

#------------------------------------------------------------------------
sub LoadAllreadyLoadedModule {
    my $self = shift;
    my $SubTestName = (caller(0))[3];

    use TypeTests;
    my $Tools = Tools->new();
    my $ModulePath = 'TypeTests.pm';
    is( $INC{$ModulePath}, $ModulePath, "$SubTestName - the module: $ModulePath is allready loaded");
    $Tools->loadPackage('TypeTests');
    is( $INC{$ModulePath}, $ModulePath, "$SubTestName - the module: $ModulePath is still loaded");

    return;
}

__PACKAGE__->RunTest();
1;
