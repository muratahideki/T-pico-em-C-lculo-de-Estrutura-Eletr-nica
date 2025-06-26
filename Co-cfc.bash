#!/usr/bin/bash

#O shebang (ou "hashbang") é a primeira linha de um script executável, usada para indicar qual interpretador deve rodar o script.No caso vamos usar o bash como interpretador e mostramos o caminho dele.

N=`seq -10 2 10`
# Isso gera uma sequência de -10 a 10, com intervalo de 2

a0=6.27389323421
for n in $N
do

a=$(echo "$a0*(1+$n/100)" | bc -l)

#cat serve para concatenar arquivos, ele vai fazer isso até o EOF(end of file)
cat > niobio-$n.in << EOF

&CONTROL
    calculation = 'scf'
    title = 'Co-CFC'
    outdir = './tmp/'
    prefix = 'Co-CFC'
    etot_conv_thr = 1d-5
    pseudo_dir = './pseudos/'
/
&SYSTEM
    ibrav = 2
    celldm(1) = $a
    nat = 1
    ntyp = 1
    nspin = 2
    starting_magnetization(1) = 2.5
    ecutwfc = 90
    occupations = 'smearing'
    smearing = 'mv'
    degauss = 0.001
/
&ELECTRONS
/

ATOMIC_SPECIES
 Co 58.933 co_pbe_v1.2.uspp.F.UPF

ATOMIC_POSITIONS crystal
 Co 0.0 0.0 0.0

K_POINTS automatic
20 20 20 1 1 1

EOF

pw.x -i niobio-$n.in | tee niobio-$n.out
#Gera dinamicamente o arquivo niobio-$n.in, onde $n é o índice da variação (%).

done

