package Bowling::Game;

use Bowling::Frame;

use Class::Accessor::Lite (
               new => 0,
               rw  => [ qw(frames current_frame current_throw) ],
           );

sub new {

  my ($self, %params) = @_;
  my $obj = bless \%params, $self;

  my @frames = ();
  my $prev;
  for my $no(1..10){
    my $new = Bowling::Frame->new();
    $new->num($no);
    push @frames, $new;
    if (defined $prev){
      $prev->nextFrame($new);
    }
    $prev = $new;

  }
  $obj->current_frame(1);
  $obj->current_throw(1);
  $obj->frames(\@frames);
  
  return $obj;


}

sub roll {
  my $self = shift;
  my $count = shift;
  $self->frames->[$self->current_frame -1 ]->roll($self->current_throw, $count);
  if ($self->current_frame == 10){
    my $throw = $self->current_throw();
    $throw++;
    $self->current_throw($throw);
   }
  else{
    if (($self->current_throw == 1 && $count == 10) || $self->current_throw == 2 ){
      my $frame = $self->current_frame();
      $frame++;
      $self->current_frame($frame);
      $self->current_throw(1);
    }
    else{
      my $throw = $self->current_throw();
      $throw++;
      $self->current_throw($throw);
    }
  }
}


sub score {
  my $self = shift;
  my $sum = 0;
  for $index(1.. $self->current_frame){
    $sum = $sum + $self->frames->[$index-1]->score;
  }
  return $sum
}


1;
