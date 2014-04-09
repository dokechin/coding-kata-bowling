package Bowling::Frame;

use Class::Accessor::Lite (
               new => 0,
               rw  => [ qw(num rolls nextFrame) ],
           );

sub new {

  my $klass = shift;
  my $obj = bless {
      (@_ == 1 && ref($_[0]) eq 'HASH' ? %{$_[0]} : @_),
    }, $klass;
  if ($obj->num == 10){
    $obj->rolls ([undef,undef,undef]);
  }
  else{
    $obj->rolls ([undef,undef]);
  }

  return $obj;

}


sub roll {
  my $self = shift;
  my $throw = shift;
  my $count = shift;
  $self->rolls->[$throw - 1] = $count;
}

sub get_roll{
  my $self = shift;
  my $throw = shift;
  return $self->rolls->[$throw - 1];

}
sub score {
  my $self = shift;
  my $sum = 0;
  for my $count( @{$self->rolls}){
    $sum = $sum + $count;
  }
  if ($self->num != 10 && $sum == 10){
    if ($self->get_roll(1) == 10){
      if ($self->num == 9){
        $sum = $sum + $self->nextFrame->get_roll(1);
        $sum = $sum + $self->nextFrame->get_roll(2);
      }
      else{
        $sum = $sum + $self->nextFrame->get_roll(1);
        if ($self->nextFrame->get_roll(1) == 10){
          $sum = $sum + $self->nextFrame->nextFrame->get_roll(1);
        }
        else{
          $sum = $sum + $self->nextFrame->get_roll(2);
        }
      }
    }
    else{
      $sum = $sum + $self->nextFrame->get_roll(1);
    }
  }
  return $sum;
}

1;
