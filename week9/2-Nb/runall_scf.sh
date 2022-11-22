material="Nb"
prefix="/work1/b07202020/week9/2-${material}"
declare -a cellArr=("primitive" "sic2" "sic16")
declare -a smearingArr=("tetrahedron" "gaussian")
declare -a kpointsArr=("10" "16" "20")

# run scf
for cell in "${cellArr[@]}"; do
    for kpoints in "${kpointsArr[@]}"; do
        dir="${prefix}/${material}-${cell}/${kpoints}/0-scf"
        cd ${dir}
        qsub ./job.sh
    done
done
