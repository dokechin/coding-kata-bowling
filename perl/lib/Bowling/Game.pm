package Bowling::Game;

use Class::Accessor::Lite (
               new => 1,
               rw  => [ qw(frames current_frame current_throw) ],
           );
use Bowling::Frame;

sub init {

  my $self = shift;

  my @frames = ();
  my $prev;
  for my $no(1..10){
    my $new = Bowling::Frame->new({number => $no});
    push @frames, $new;
    if (defined $prev){
      $prev->nextFrame = $new;
    }
    $prev = $new;
  }
  $self->current_frame = 1;
  $self->current_throw = 1;
  $self->frames = \@frames;

  warn("called");

}

sub roll {
  my $self = shift;
  my $count = shift;
  $self->frames->[$self->current_frame]->roll($self->current_throw, $count);
  if ($self->current_frame == 10){
    $self->current_throw++;
  }
  else{
    if (($self->current_throw == 1 &&$count == 10) || $self->current_throw == 2 ){
      $self->current_frame++;
      $self->current_throw = 1;
    }
    else{
      $self->current_throw++;
    }
  }
}


sub score {
  my $self = shift;
  my $sum = 0;
  for $index(1.. $self->current_frame){
    $sum = $sum + $self->frames->[$index]->score;
  }
  return $sum
}


1;
