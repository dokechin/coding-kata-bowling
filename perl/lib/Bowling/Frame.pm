package Bowling::Frame;

use Class::Accessor::Lite (
               new => 1,
               rw  => [ qw(number rolls nextFrame) ],
           );

sub init {
  my $self = shift;
  if ( $self->number == 10){
    $self->rolls = [undef,undef,undef];
  }
  else{
    $self->rolls = [undef,undef];
  }
}

sub roll {
  my $self = shift;
  my $throw = shift;
  my $count = shift;
  $self->rolls->[$throw] = $count;
}


sub score {
  my $self = shift;
  my $sum = 0;
  for my $count( $self->rolls){
    $sum = $sum + $count;
  }
  if ($self->number != 10 && $sum == 10){
    if ($self->rolls->[0] == 10){
      if ($self->number == 9){
        $sum = sum + $self->nextFrame->rolls->[0];
        $sum = sum + $self->nextFrame->rolls->[1];
      }
      else{
        $sum = sum + $self->nextFrame->rolls->[0];
        if ($self->nextFrame->rolls->[0] == 10){
          $sum = sum + $self->nextFrame->nextFrame->rolls->[1];
        }
        else{
          $sum = sum + $self->nextFrame->rolls->[1];
        }
      }
    }
    else{
      $sum = sum + $self->nextFrame->rolls->[1];
    }
  }
  return $sum;
}

1;
