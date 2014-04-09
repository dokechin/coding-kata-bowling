package Bowling::Frame;

use Class::Accessor::Lite (
               new => 0,
               rw  => [ qw(num rolls nextFrame) ],
           );

sub new {

  my ($self, %params) = @_;

  my $obj = bless  \%params, $self;
  $obj->rolls ([0,0,0]);

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
