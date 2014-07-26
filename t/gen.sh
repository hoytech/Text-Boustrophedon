echo
echo GREEK
echo
perl -I lib -CAS -MText::Boustrophedon -E 'local $/; print Text::Boustrophedon::greek(<>)' < t/input.txt
echo
echo REVERSE
echo
perl -I lib -CAS -MText::Boustrophedon -E 'local $/; print Text::Boustrophedon::reverse(<>)' < t/input.txt
echo
echo RONGORONGO
echo
perl -I lib -CAS -MText::Boustrophedon -E 'local $/; print Text::Boustrophedon::rongorongo(<>)' < t/input.txt
