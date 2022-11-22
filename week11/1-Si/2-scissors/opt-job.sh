###############################################
#       Intel MPI job script example          #
###############################################

#!/bin/bash
#PBS -l select=1:ncpus=40:mpiprocs=40
#PBS -N vasp
#PBS -q ct160
#PBS -P ACD111118
#PBE -j o out
#PBE -j e err

cd $PBS_O_WORKDIR

module load intel/2017_u4

export I_MPI_HYDRA_PMI_CONNECT=alltoall
export I_MPI_HYDRA_BRANCH_COUNT=-1

mpiexec.hydra -PSM2 /home/r05222063/NTU/vasp/vasp_opt

