material="Nb"
prefix="/work1/b07202020/week9/2-${material}"
declare -a cellArr=("primitive" "sic2" "sic16")
declare -a smearingArr=("tetrahedron" "gaussian")
declare -a kpointsArr=("10" "16" "20")

# run scf
for cell in "${cellArr[@]}"; do
    for kpoints in "${kpointsArr[@]}"; do
        for smearing in "${smearingArr[@]}"; do
            dir="${prefix}/${material}-${cell}/${kpoints}/1-dos-${smearing}"
            chgdir="${prefix}/${material}-${cell}/${kpoints}/0-scf"
            cd ${dir}
            cp "${chgdir}/CHGCAR" ./
            qsub job.sh
        done
    done
done
