#!/bin/bash

if [[ -z $1 ]] || [[ ! -e asm.fasta ]] ; then
	echo "Usage: ./_submit_scaff10x_v4.0.sh <genome_id> [dir_path_of_fastq.gz_files] [job_id_to_wait_for]"
	echo "Requires asm.fasta and input.dat - give the dir path to R1 fastq.gz, R2 fastq.gz files to automatically generate input.dat"
	echo
	"
	Example input.dat: \
	q1=/lustre/scratch116/vr/projects/Tes1_S1_L008_R1_001.fastq.gz
	q2=/lustre/scratch116/vr/projects/Tes1_S1_L008_R2_001.fastq.gz
	q1=/lustre/scratch116/vr/projects/Tes1_S2_L008_R1_001.fastq.gz
	q2=/lustre/scratch116/vr/projects/Tes1_S2_L008_R2_001.fastq.gz
	q1=/lustre/scratch116/vr/projects/Tes1_S3_L008_R1_001.fastq.gz
	q2=/lustre/scratch116/vr/projects/Tes1_S3_L008_R2_001.fastq.gz
	q1=/lustre/scratch116/vr/projects/Tes1_S4_L008_R1_001.fastq.gz
	q2=/lustre/scratch116/vr/projects/Tes1_S4_L008_R2_001.fastq.gz"
	echo "[job_id_to_wait_for]: Wait after the job finishes and launch"
	exit -1
fi

if [ ! -z $2 ]; then
	path=$2
	ls $path/*_R[1-2]_001.fastq.gz | awk '{if (NR%2==1) {print "p1="$0} else {print "p2="$0}}' > input.dat
fi

mkdir -p logs

dependency=$3
if [ ! -z $dependency ]; then
	dependency="--dependency=afterok:$2"
fi

cpus=54
mem=64g
name=scaff10x_$1
script=$VGP_PIPELINE/scaff10x/scaff10x_v4.0.sh
args=$1
walltime=3-0
dependency=$dependency
log=logs/$name.%A_%a.log
echo "\
sbatch --partition=norm --cpus-per-task=$cpus --job-name=$name $dependency --mem=$mem --time=$walltime --error=$log --output=$log $script $args"
#sbatch --partition=norm --cpus-per-task=$cpus --job-name=$name $dependency --mem=$mem --time=$walltime --error=$log --output=$log $script $args
