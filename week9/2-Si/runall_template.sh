material="Si"
prefix="/work1/b07202020/week9/2-${material}"
declare -a cellArr=("primitive" "sic")
declare -a smearingArr=("tetrahedron" "gaussian")
declare -a kpointsArr=("10" "16" "20")

# run scf
for cell in "${cellArr[@]}"; do
    for kpoints in "${kpointsArr[@]}"; do
        dir="${prefix}/${material}-${cell}/${kpoints}/0-scf"
        cd ${dir}
        cp "/work1/b07202020/week9/2-Si/Si-sic/20/0-scf/INCAR" ./INCAR
    done
done
