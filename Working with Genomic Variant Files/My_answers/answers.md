ps: because of M1 mac, I use micromamba and `brew install bcftools`;
`bcftools filter` includes meta-info and header lines 	3.47

# Answers to questions from "Genomic Variant Files"


Q1: How many positions are found in this region in the VCF file?
A:  `tabix CEU.exon.2010_03.genotypes.vcf.gz 1:1105411-44137860 | wc -l`
    69


Q2: How many samples are included in the VCF file?
A:  `bcftools query -l CEU.exon.2010_03.genotypes.vcf.gz | wc -l `
    90


Q3: How many positions are there total in the VCF file?
A: `bcftools query -f '%POS\n' CEU.exon.2010_03.genotypes.vcf.gz | wc -l`
    3489

Q4: How many positions are there with AC=1? Note that you cannot simply count lines since the output of bcftools filter includes the VCF header lines. You will need to use bcftools query to get this number.
A: `bcftools filter -i AC=1 CEU.exon.2010_03.genotypes.vcf.gz | bcftools query -f '%CHROM %POS\n' | wc -l`
    1075

Q5: What is the ratio of transitions to transversions (ts/tv) in this file?
A: `bcftools stats CEU.exon.2010_03.genotypes.vcf.gz` 
    ts/tv :3.47
    ts/tv (1st ALT): 3.47


Altering a VCF file: 
`bcftools annotate --rename-chrs chr_name_conv.txt CEU.exon.2010_03.genotypes.vcf.gz > CEU.exon.2010_03.genotypes.chr_conv.vcf.gz`


Q6: What is the median number of variants per sample in this data set?
A: 28


