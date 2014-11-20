#!/bin/sh
TESTFILE=testslist
OLDIFS=$IFS
IFS=$'\n'
declare -i total=0
declare -i failed=0
echo "STARTING TESTS" | tee results
echo "" | tee results
for line in $(<$TESTFILE)
do
	total=$(( total + 1))
	echo "----> lslog$total" > logs/lslog$total
	echo "----> ftlslog$total" > logs/ftlslog$total
	echo "[TEST$total] \"ls $line\"" | tee -a results logs/lslog$total logs/ftlslog$total
	script "logs/lslog$total" -aqc "ls $line" > /dev/null
	script "logs/ftlslog$total" -aqc "./ft_ls $line" > /dev/null
	sed -n '4,$p' "logs/lslog$total" > logs/lstmp
	sed -n '4,$p' "logs/ftlslog$total" > logs/ftlstmp
	DIFF=$(diff "logs/lstmp" "logs/ftlstmp")
	if [ "$DIFF" != "" ]
	then
		failed=$(( failed + 1 ))
		echo "$DIFF" >> results
		echo "--------> [FAIL]" | tee -a results
	else
		echo "--> [PASS]" | tee -a results
	fi
	echo "" | tee -a results
done
if [ $failed != 0 ]
then
	echo "TESTING DONE, FAILED $failed TESTS ON $total TOTAL" | tee -a results
	echo "See the results file for more information about failed tests"
else
	echo "TESTING DONE, ALL $total TESTS PASSED" | tee -a results
fi
echo "See the logs files for tests output"
IFS=$OLDIFS
