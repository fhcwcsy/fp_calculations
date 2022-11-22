material="Nb"
prefix="/work1/b07202020/week9/2-${material}"
declare -a cellArr=("primitive" "sic2" "sic16")
declare -a smearingArr=("tetrahedron" "gaussian")
declare -a kpointsArr=("10" "16" "20")

rm -rf ${material}-*

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
Monkhorst
${kpoints} ${kpoints} ${kpoints}
0 0 0
!

            # generate POSCAR
            if [[ ${cell} == "primitive" ]] ; then
cat >POSCAR <<!
${cell} ${material}
3.3008
-0.5    0.5     0.5
 0.5   -0.5     0.5
 0.5    0.5    -0.5
${material}
1
Direct
0       0       0
!
            fi

            if [[ ${cell} == "sic2" ]] ; then
cat >POSCAR <<!
${cell} ${material}
3.3008
1       0       0
0       1       0
0       0       1
${material}
2
Direct
0       0       0
0.5     0.5     0.5
!
            fi

            if [[ ${cell} == "sic16" ]] ; then
cat >POSCAR <<!
${cell} ${material}
3.3008
2       0       0
0       2       0
0       0       2
${material}
16
Direct
0       0       0
0.25    0.25    0.25
0.5     0       0
0.75    0.25    0.25
0       0.5     0
0.25    0.75    0.25
0       0       0.5
0.25    0.25    0.75
0.5     0.5     0
0.75    0.75    0.25
0       0.5     0.5
0.25    0.75    0.75
0.5     0       0.5
0.75    0.25    0.75
0.5     0.5     0.5
0.75    0.75    0.75
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
Monkhorst
${kpoints} ${kpoints} ${kpoints}
0 0 0
!

            # generate POSCAR
            if [[ ${cell} == "primitive" ]] ; then
cat >POSCAR <<!
${cell} ${material}
3.3008
-0.5    0.5     0.5
 0.5   -0.5     0.5
 0.5    0.5    -0.5
${material}
1
Direct
0       0       0
!
            fi

            if [[ ${cell} == "sic2" ]] ; then
cat >POSCAR <<!
${cell} ${material}
3.3008
1       0       0
0       1       0
0       0       1
${material}
2
Direct
0       0       0
0.5     0.5     0.5
!
            fi

            if [[ ${cell} == "sic16" ]] ; then
cat >POSCAR <<!
${cell} ${material}
3.3008
2       0       0
0       2       0
0       0       2
${material}
16
Direct
0       0       0
0.25    0.25    0.25
0.5     0       0
0.75    0.25    0.25
0       0.5     0
0.25    0.75    0.25
0       0       0.5
0.25    0.25    0.75
0.5     0.5     0
0.75    0.75    0.25
0       0.5     0.5
0.25    0.75    0.75
0.5     0       0.5
0.75    0.25    0.75
0.5     0.5     0.5
0.75    0.75    0.75
!
        fi
        # copy other necessary files
        cp "${prefix}/job.sh" ./
        cp "${prefix}/POTCAR" ./
            
    done
done
