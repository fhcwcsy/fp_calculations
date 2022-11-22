material="Si"
prefix="/work1/b07202020/week9/2-${material}"
declare -a cellArr=("primitive" "sic")
declare -a smearingArr=("tetrahedron" "gaussian")
declare -a kpointsArr=("10" "16" "20")

rm -rf Si-*

for cell in "${cellArr[@]}"; do
    for kpoints in "${kpointsArr[@]}"; do
        for smearing in "${smearingArr[@]}"; do
            dir="${prefix}/${material}-${cell}/${kpoints}/1-dos-${smearing}"
            mkdir -p ${dir}
            cd ${dir}

            if [[ ${smearing} == "tetrahedron" ]] ; then
                smearingCode="-5"
            fi
            if [[ ${smearing} == "gaussian" ]] ; then
                smearingCode="0"
            fi

            # generate INCAR
cat >INCAR <<!
System = ${material} ${smearing}
ENCUT = 300
EDIFF = 1e-7
ISMEAR = ${smearingCode}
ICHARG = 11
LCHARG = .FALSE.
!
            # generate KPOINTS
cat >KPOINTS <<!
${kpoints}*${kpoints}*${kpoints}
0
Gamma
${kpoints} ${kpoints} ${kpoints}
0 0 0
!

            # generate POSCAR
            if [[ ${cell} == "primitive" ]] ; then
cat >POSCAR <<!
${cell} ${material}
5.43
 0.0    0.5     0.5
 0.5    0.0     0.5
 0.5    0.5     0.0
Si
2
Direct
0       0       0
0.25    0.25    0.25
!
            fi

            if [[ ${cell} == "sic" ]] ; then
cat >POSCAR <<!
${cell} ${material}
5.43
1       0       0
0       1       0
0       0       1
Si
8
Direct
0       0       0
0.5     0.5     0
0       0.5     0.5
0.5     0       0.5
0.25    0.25    0.25
0.75    0.75    0.25
0.25    0.75    0.75
0.75    0.25    0.75
!
            fi

            # copy other necessary files
            cp "${prefix}/job.sh" ./
            cp "${prefix}/POTCAR" ./
            
        done
    done
done

for cell in "${cellArr[@]}"; do
    for kpoints in "${kpointsArr[@]}"; do
        dir="${prefix}/${material}-${cell}/${kpoints}/0-scf"
        mkdir -p ${dir}
        cd ${dir}

            # generate INCAR
cat >INCAR <<!
System = ${material}
ENCUT = 300
EDIFF = 1e-7
ISMEAR = -5
!
            # generate KPOINTS
cat >KPOINTS <<!
${kpoints}*${kpoints}*${kpoints}
0
Gamma
${kpoints} ${kpoints} ${kpoints}
0 0 0
!

            # generate POSCAR
            if [[ ${cell} == "primitive" ]] ; then
cat >POSCAR <<!
${cell} ${material}
5.43
 0.0    0.5     0.5
 0.5    0.0     0.5
 0.5    0.5     0.0
Si
2
Direct
0       0       0
0.25    0.25    0.25
!
            fi

            if [[ ${cell} == "sic" ]] ; then
cat >POSCAR <<!
${cell} ${material}
5.43
1       0       0
0       1       0
0       0       1
Si
8
Direct
0       0       0
0.5     0.5     0
0       0.5     0.5
0.5     0       0.5
0.25    0.25    0.25
0.75    0.75    0.25
0.25    0.75    0.75
0.75    0.25    0.75
!
            fi

            # copy other necessary files
            cp "${prefix}/job.sh" ./
            cp "${prefix}/POTCAR" ./
            
    done
done
