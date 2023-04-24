#!/bin/bash
#SBATCH -J GROMACS-DCU
#SBATCH -p xahdtest
#SBATCH -N 1
#SBATCH -n 32
#SBATCH --gres=dcu:4
#SBATCH --exclusive

module purge
module load compiler/devtoolset/7.3.1 
module load mpi/hpcx/gcc-7.3.1 
module load mathlib/fftw/3.3.8-gcc-7.3.1-single 
module load compiler/dtk/22.04.2 
module load anaconda3/5.2.0
module load gromacs/2022.1-DCU2-hpcx-gcc-7.3.1

gmx_mpi grompp -f nvt.mdp -c em.gro -p complex.top -o nvt-pr.tpr -n index.ndx -r em.gro
#cmd1='gmx_mpi mdrun -v -pin on -nb gpu -deffnm nvt-pr'
mpirun --allow-run-as-root -np 4 gmx_mpi mdrun -v -pin on -nb gpu -deffnm nvt-pr

