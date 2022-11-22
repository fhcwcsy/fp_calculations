###############################################
#       Intel MPI job script example          #
###############################################

#!/bin/bash
#PBS -l select=1:ncpus=1:mpiprocs=1
#PBS -N vasp
#PBS -q serial
#PBS -P ACD111118
#PBE -j o out
#PBE -j e err

cd $PBS_O_WORKDIR

module load intel/2017_u4

export I_MPI_HYDRA_PMI_CONNECT=alltoall
export I_MPI_HYDRA_BRANCH_COUNT=-1

rm -r ev.csv

for a in $(seq 3.95 0.02 4.15);
do
echo "a= $a"

cat >POSCAR <<!
Na
$a
-0.5     0.5     0.5
 0.5    -0.5     0.5
 0.5     0.5    -0.5
Na
1
Direct
0 0 0 Na
!


mpiexec.hydra -PSM2 /home/r05222063/NTU/vasp/vasp_ncl

E=`grep "energy without entropy" OUTCAR |tail -1|awk '{printf "%12.6f\n",$5}'`
V=`echo $a | awk '{printf "%f",$0*$0*$0/2}'`
echo $a, $V, $E >> ev.csv
rm WAVECAR
done
