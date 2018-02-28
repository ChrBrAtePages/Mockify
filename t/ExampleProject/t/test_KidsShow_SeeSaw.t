package test_KidsShow_SeeSaw;
use strict;
use FindBin;
use lib ($FindBin::Bin);
use parent 'TestBase';
use Test::More;
use Test::Mockify;
use Test::Mockify::Matcher qw (Number);
use t::ExampleProject::KidsShow::SeeSaw;
#------------------------------------------------------------------------
sub testPlan{
    my $self = shift;

    # To find the right numbers in order to have predictiable results for the 'clown-classes' is not the scope of this class
    # This test takes care of the right behavior of the seesaw
    my $Mockify = Test::Mockify->new('t::ExampleProject::KidsShow::SeeSaw',[]);
    $Mockify->mockImported('t::ExampleProject::KidsShow::NewClown','ShowOfWeight')->when(Number(10))->thenReturn(10);
    $Mockify->mockImported('t::ExampleProject::KidsShow::NewClown','ShowOfWeight')->when(Number(20))->thenReturn(20);
    $Mockify->mockStatic('t::ExampleProject::KidsShow::OldClown::BeHavy')->when(Number(10))->thenReturn(10);
    $Mockify->mockStatic('t::ExampleProject::KidsShow::OldClown::BeHavy')->when(Number(20))->thenReturn(20);

    my $SeeSaw = $Mockify->getMockObject();

    is($SeeSaw->upAndDown(10, 10), 'balanced', 'prove if the seesaw can be balanced');
    is($SeeSaw->upAndDown(10, 20),'Old clown wins', 'prove if the seesaw can toss to the right');
    is($SeeSaw->upAndDown(20, 10),'New clown wins', 'prove if the seesaw can toss to the left');

    return;
}

__PACKAGE__->RunTest();
1;