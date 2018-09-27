#!/bin/bash	
#SBATCH -p cn-short
#SBATCH -N 1
#SBATCH --ntasks-per-node=1
#SBATCH -o du.%j.out
#SBATCH -e du.%j.err
#SBATCH --no-requeue
#SBATCH -A zeminz_g1
#SBATCH --qos=zeminzcns

ls /WPSnew/zhenglt/work | awk '{print "du -cs /WPSnew/zhenglt/work/"$0}' | bash
