#!/bin/sh
TESTFILE=testslist
TESTDIR=tests
COLUMNS=false
NO_ONE=true
OLDIFS=$IFS
IFS=$'\n'
declare -i total=0
declare -i failed=0
echo "STARTING TESTS" | tee results
for line in $(grep -v '^#' $TESTFILE)
do
	echo "----> lslog$total" > logs/lslog$total
	echo "----> ftlslog$total" > logs/ftlslog$total
	echo "[TEST$total] \"ls $line $TESTDIR\"" | tee -a results logs/lslog$total logs/ftlslog$total
	if [ "$COLUMNS" = "true" ]
	then
		script -aq "logs/lslog$total" "ls" "$line" "$TESTDIR" > /dev/null
		script -aq "logs/ftlslog$total" "./ft_ls" "$line" "$TESTDIR" > /dev/null
	else
		script -aq "logs/lslog$total" "ls" "-1" "$line" "$TESTDIR" > /dev/null
		if [ "$NO_ONE" = "true" ]
		then
			script -aq "logs/ftlslog$total" "./ft_ls" "$line" "$TESTDIR" > /dev/null
		else
			script -aq "logs/ftlslog$total" "./ft_ls" "-1" "$line" "$TESTDIR" > /dev/null
		fi
	fi
	sed -n '3,$p' "logs/lslog$total" > logs/lstmp
	sed -n '3,$p' "logs/ftlslog$total" >  logs/ftlstmp
	DIFF=$(diff "logs/lstmp" "logs/ftlstmp")
	if [ "$DIFF" != "" ]
	then
		failed=$(( failed + 1 ))
		echo "$DIFF" >> results
		echo "[\033[31mFAIL\033[0m]" | tee -a results
	else
		echo "[\033[032mPASS\033[0m]" | tee -a results
	fi
	total=$(( total + 1))
done
if [ $failed != 0 ]
then
	echo "\033[31mTESTING DONE, FAILED $failed TESTS ON $total TOTAL\033[0m" | tee -a results
	echo "See the results file for more information about failed tests"
else
	echo "\033[32mTESTING DONE, ALL $total TESTS PASSED\033[0m" | tee -a results
fi
echo "See the logs files for tests output"
IFS=$OLDIFS
