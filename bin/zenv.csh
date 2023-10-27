#!bin/tcsh -f

if(! -e "bin/setup.csh") then
	echo "source bin/setup \n"
	exit
endif

module load vcs/S-2021.09-SP2-3_P
module load verdi/S-2021.09-SP2-3_P

echo "workspace is ready for $WORKSPACE"