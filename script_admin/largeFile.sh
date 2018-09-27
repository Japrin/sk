#!/bin/bash	
#SBATCH -p cn-short
#SBATCH -N 1
#SBATCH --ntasks-per-node=1
#SBATCH -o largeFile.%j.out
#SBATCH -e largeFile.%j.err
#SBATCH --no-requeue
#SBATCH -A zeminz_g1
#SBATCH --qos=zeminzcns

tDir="/WPSnew/zhenglt/work/"
oDir=largeFile
mkdir -p $oDir
ofile=$oDir/Scan_`date +%Y%m%d_%T`
(
echo ====== begin at: `date` ======


find  $tDir \( -name "*.txt" -o -name "*.tmp" -o -name "*.fq" -o -name "*.fa" -o -name "*.fasta" -o -name "*.log" -o -name "core." -o -name "*.sh.e*" -o -name "*.sh.o*" -o -name "*.sam" -o -name "*.out" \) -type f -size +50M -exec ls -l \{\} +

echo ====== end at: `date` ======

) | awk '!/^==/{print $3"\t"$5"\t"$9}' | sort -k 2gr,2 > $ofile.detail.txt

perl -F"\t" -ane '$h{$F[0]}+=$F[1];END{foreach (sort { $h{$b}<=>$h{$a} } keys %h){print "$_\t$h{$_}\n"}}' $ofile.detail.txt >  $ofile.summary.txt
