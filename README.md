ft_ls_tests
===========

HOW TO:

-Clone this in the directory that contains you repo (not in the actual repo)
if your repo is not named ft_ls, rename it or change the FTLSDIR variable in the makefile.

-Run make

You can specify a test directory in the run_tests.sh script with the TESTDIR variable

The testslist file contains one test per line, you can add yours there. Line begining with # are comments.

The makefile will run make in your ft_ls repo, copy the binaries and run the run_tests.sh script

COMMENT CA MARCHE:

-Clonez dans le repertoire qui contient votre dépot (et non pas directement dans votre dépot)
si votre dépot ne s'apelle pas ft_ls, renomez le ou changez la variable FTLSDIR dans le makefile

-Executez make

Vous pouvez preciser un dossier de test dans le script run_tests.sh grace a la variable TESTDIR

Le fichier testslist contient un test par ligne, vous pouvez ajouter les votres dedans. Les lignes commencant par # ne sont pas prise en compte.

Le makefile va apeller make dans votre dépot, copier le fichier binaire et lancer le script run_tests.sh.
