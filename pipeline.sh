# Shell script for processing next-generation sequencing data
# This script performs initial data preparation, quality control, and alignment.

# Step 1: Data Preparation - Extract and organize sequencing data
for filename in *.lite.1; do 
    base=$(basename $filename .lite.1); echo $base
    mkdir ${base}
    mv ${base}.lite.1 ${base}/
    cd ${base}
    fastq-dump --split-files ${base}.lite.1
    cd /data/med-macc/Qingdao/niaoye
done

# Step 2: Quality Control - Trim low-quality bases and remove adapters
for filename in SRR*; do 
    base=$(basename $filename ); echo $base
    cd ${base}
    java -jar /data/med-macc/tools/Trimmomatic-0.39/trimmomatic-0.39.jar PE -threads 24 -phred33 ${base}.lite.1_1.fastq ${base}.lite.1_2.fastq ${base}_1.paired.fq ${base}_1.unpaired.fq ${base}_2.paired.fq ${base}_2.unpaired.fq ILLUMINACLIP:/data/med-macc/tools/Trimmomatic-0.39/adapters/TruSeq3-PE-2.fa:2:30:10:8:true TRAILING:20 MINLEN:60
    cd /data/med-macc/Qingdao/niaoye
done

# Step 3: Alignment - Map reads to a reference database
for filename in SRR*; do 
    base=$(basename $filename ); echo $base
    cd ${base}
    bowtie2 -p 24 -x /data/med-macc/tools/database/VFDB/vfdb.index -1 ${base}_1.paired.fq -2 ${base}_2.paired.fq -S ${base}-vfdb.sam
    samtools view -bS ${base}-vfdb.sam -o ${base}-vfdb.bam
    samtools sort -m 10000000000 ${base}-vfdb.bam -o ${base}-vfdb.sort.bam
    samtools index ${base}-vfdb.sort.bam
    samtools idxstats ${base}-vfdb.sort.bam | tee -a ${base}-vfdb.txt
    cd /data/med-macc/Qingdao/niaoye
done