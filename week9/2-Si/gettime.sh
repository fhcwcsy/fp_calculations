rm -f time.txt

material="Si"
declare -a cellArr=("primitive" "sic")
declare -a smearingArr=("tetrahedron" "gaussian")
declare -a kpointsArr=("10" "16" "20")

for cell in "${cellArr[@]}"; do
    for kpoints in "${kpointsArr[@]}"; do
        for smearing in "${smearingArr[@]}"; do
            dir="./${material}-${cell}/${kpoints}/1-dos-${smearing}"
            outcar="${dir}/OUTCAR"
            cpuTime=`grep "Total CPU time used" ${outcar} | awk '{print $6}'`
            echo ${material} ${cell} ${kpoints} ${smearing} ${cpuTime} >> time.txt
        done
    done
done
