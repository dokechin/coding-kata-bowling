package t::Bowling::Frame;
use warnings;

use parent qw(Test::Class);
use Test::More;

sub _require : Test(startup => 1) {
    require_ok('Bowling::Frame');
}

sub _prepare_game : Test(setup => 1) {
    my ($self) = @_;

    $self->{frame} = Bowling::Frame->new();
    $self->{frame}->num(1);
    $next1 = Bowling::Frame->new();
    $next1->num(2);
    $next2 = Bowling::Frame->new();
    $next2->num(3);
    $self->{frame}->nextFrame( $next1)->nextFrame($next2);
    isa_ok $self->{frame}, 'Bowling::Frame';
}


sub open_frame : Tests {
    my ($self) = @_;
    my $frame = $self->{frame};

    $frame->roll(1,3);
    $frame->roll(2,3);
    is     $frame->num, 1;
    is $frame->score, 6, 'score of frame';
}

sub spare_frame : Tests {
    my ($self) = @_;
    my $frame = $self->{frame};

    $frame->roll(1,3);
    $frame->roll(2,7);
    $frame->nextFrame->roll(1,10);

    is     $frame->num, 1;
    is $frame->score, 20, 'score of frame of spare';
}

sub strike_frame_next_open : Tests {
    my ($self) = @_;
    my $frame = $self->{frame};

    $frame->roll(1,10);
    $frame->nextFrame->roll(1,3);
    $frame->nextFrame->roll(2,3);

    is     $frame->num, 1;
    is $frame->score, 16, 'score of frame of strike and next open';
}

sub turkey_frame : Tests {
    my ($self) = @_;
    my $frame = $self->{frame};

    $frame->roll(1,10);
    $frame->nextFrame->roll(1,10);
    $frame->nextFrame->nextFrame->roll(1,10);

    is     $frame->num, 1;
    is $frame->score, 30, 'turkey';
}


Test::Class->runtests;

1;
