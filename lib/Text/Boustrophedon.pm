package Text::Boustrophedon;

use strict;
use 5.010;
use utf8;

our $VERSION = '0.100';

use Text::WrapI18N;


our $columns = $Text::WrapI18N::columns;


## Mappings from http://www.twiki.org/cgi-bin/view/Blog/BlogEntry201211x1 and Text::UpsideDown

my @input_chars = split //, "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
my @mirror_chars = split //, "ɒdɔbɘʇǫʜiႱʞlmnoqpɿƨƚuvwxyzAᙠƆᗡƎᖷᎮHIႱᐴ⅃MИOꟼỌЯƧTUVWXYƸ";
my @flipped_chars = split //, "ɐpⅽqөʈɓµ!ɾʞlwuobdʁƨʇ∩٨ʍxʎzᗄᗷ⊂DEᖶ⅁HIᘃʞ⅂ʍиObÕᖉᴤ⊥∩⋀MX⅄Z";
my @upsidedown_chars = split //, "ɐqɔpǝɟƃɥıſʞןɯuodbɹsʇnʌʍxʎz∀ξↃ◖ƎℲ⅁HIſ⋊⅂WᴎOԀΌᴚS⊥∩ᴧMX⅄Z";

my $mirror_map = {};
my $flipped_map = {};
my $upsidedown_map = {};

for(my $i=0; $i<@input_chars; $i++) {
  $mirror_map->{$input_chars[$i]} = $mirror_chars[$i];
  $flipped_map->{$input_chars[$i]} = $flipped_chars[$i];
  $upsidedown_map->{$input_chars[$i]} = $upsidedown_chars[$i];
}

sub mirror { join '', map { $mirror_map->{$_} // $_ } split //, shift }
sub flipped { join '', map { $flipped_map->{$_} // $_ } split //, shift }
sub upsidedown { join '', map { $flipped_map->{$_} // $_ } split //, shift }



sub greek {
  my $v = shift;

  local $Text::WrapI18N::columns = $columns;

  $v = Text::WrapI18N::wrap("", "", $v);

  $v =~ s{(.*)\n(.*)(?:\n|$)}{process_pair($1, $2, \&mirror)}eg;

  return $v;
}

sub reverse {
  my $v = shift;

  local $Text::WrapI18N::columns = $columns;

  $v = Text::WrapI18N::wrap("", "", $v);

  $v =~ s{(.*)\n(.*)(?:\n|$)}{process_pair($1, $2)}eg;

  return $v;
}

sub rongorongo {
  my $v = shift;

  local $Text::WrapI18N::columns = $columns;

  $v = Text::WrapI18N::wrap("", "", $v);

  $v =~ s{(.*)\n(.*)(?:\n|$)}{process_pair($1, $2, \&upsidedown)}eg;

  $v = join("\n", reverse(split /\n/, $v)) . "\n";

  return $v;
}



sub process_pair {
  my ($l1, $l2, $transform) = @_;

  $l2 = reverse($l2);
  $l2 = (" " x ($Text::WrapI18N::columns - length($l2))) . $l2;

  $l2 = $transform->($l2)
    if $transform;

  return "$l1\n$l2\n";
}


1;


__END__

=encoding utf-8

=head1 NAME

Text::Boustrophedon - Write like the ox plows

=head1 SYNOPSIS

    use Text::Boustrophedon;

    $Text::Boustrophedon = 30;

    $output = Text::Boustrophedon::greek($input);

=head1 DESCRIPTION

Boustrophedon is a style of writing where whenever you hit the margin and a line break must occur, you don't return to the beginning of the next line, but instead resume writing on the next line in a reverse direction so that the previous line's end is the new line's beginning.

This was done in several ancient writing systems such as ancient greek. If you think about it, it requires less eye movement than our modern systems so maybe they were onto something. :)

The different methods currently supported are:

B<greek> -- Reverse direction and mirror-image

    Achilles glared at him and answered, "Fool, prate not to me about covenants.
     ɿɘvɘn nɒɔ ƨdmɒl bnɒ ƨɘvlow ,nɘm bnɒ ƨnoil nɘɘwƚɘd ƨƚnɒnɘvoɔ on ɘd nɒɔ ɘɿɘʜT
    be of one mind, but hate each other through and through. Therefore there can
          ƨƚnɒnɘvoɔ ynɒ ɘd ɘɿɘʜƚ yɒm ɿon ,ɘm bnɒ uoy nɘɘwƚɘd ǫnibnɒƚƨɿɘbnu on ɘd
    between us, till one or other shall fall and glut grim Ares with his life's 
                                                                         ."boold

B<reverse> -- Reverse direction only

    Achilles glared at him and answered, "Fool, prate not to me about covenants.
     reven nac sbmal dna sevlow ,nem dna snoil neewteb stnanevoc on eb nac erehT
    be of one mind, but hate each other through and through. Therefore there can
          stnanevoc yna eb ereht yam ron ,em dna uoy neewteb gnidnatsrednu on eb
    between us, till one or other shall fall and glut grim Ares with his life's 
                                                                         ."doolb

B<rongorongo> -- Reverse direction, rotate, and down-to-up direction

                                                                         ."qoolp
    between us, till one or other shall fall and glut grim Ares with his life's 
          ƨʇuɐuө٨oⅽ ʎuɐ өp өʁөµʇ ʎɐw ʁou ,өw quɐ ∩oʎ uөөʍʇөp ɓu!quɐʇƨʁөqu∩ ou өp
    be of one mind, but hate each other through and through. Therefore there can
     ʁө٨өu uɐⅽ ƨpwɐl quɐ ƨө٨loʍ ,uөw quɐ ƨuo!l uөөʍʇөp ƨʇuɐuө٨oⅽ ou өp uɐⅽ өʁөµ⊥
    Achilles glared at him and answered, "Fool, prate not to me about covenants.


NOTE: This module uses unicode characters that approximately look like their rotated or mirror-image equivalents (like L<Text::UpsideDown>) so the output values can contain "wide" characters.


=head1 SEE ALSO

L<Text-Boustrophedon github repo|https://github.com/hoytech/Text-Boustrophedon>

L<https://en.wikipedia.org/wiki/Boustrophedon>

L<http://www.twiki.org/cgi-bin/view/Blog/BlogEntry201211x1>

=head1 AUTHOR

Doug Hoyte, C<< <doug@hcsw.org> >>

=head1 COPYRIGHT & LICENSE

Copyright 2014 Doug Hoyte.

This module is licensed under the same terms as perl itself.
