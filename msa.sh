
'''
I have a file with FASTA sequences of human genes and the corresponding orthologs organized in the following way:

>human_gene_1
AABAABAB
>specie_1_ortholog_1.1_rep1
AABAABABB
>specie_2_ortholog_1.2_rep2
ABBAABABB

>human_gene_2
CDDCDCCDAC
>specie_1_ortholog_2.1_rep3
CDCCDCACCA
>specie_3_ortholog_2.3_rep4
CCCCCC

>human_gene_3
ACAABAABBABBA
>specie_1_ortholog_1.1_rep5
AABAABABB
>specie_3_ortholog_3.3_rep6
ABBABACBABB
>specie_4_ortholog_3.4_rep7
ABBABACAAABB
...
...

I want to break down this file into different files so that each file will contain only ONE human protein and all the respective orthologs


Notice that because the orthology also includes 1-to-many relationships, same gene can be ortholog to different human genes (but never vice-versa). This means that there will be repeated FASTA sequences (but not gene name/description lines as each of them has a different suffix (repX)).


'''



python counter_duplicate_lines_literally_to_fasta.py #This script will add a suffix to each NON-HUMAN FASTA sequence.

'''
The output of the python script is in following format:

>human_gene_1
AABAABAB
>specie_1_ortholog_1.1_rep1
AABAABABB_s1

>human_gene_1
AABAABAB
>specie_2_ortholog_1.2_rep2
ABBAABABB_s2

>human_gene_2
CDDCDCCDAC
>specie_1_ortholog_2.1_rep3
CDCCDCACCA_s3

>human_gene_2
CDDCDCCDAC
>specie_3_ortholog_2.3_rep4
CCCCCC_s4
...
...

I want to convert it to the following format for each file (number of files created will be equal to number of HUMAN genes):
>human_gene_1
AABAABAB
>specie_1_ortholog_1.1_rep1
AABAABABB_s1
>specie_2_ortholog_1.2_rep2
ABBAABABB_s2
'''



#Now I will run all the commands, starting from awk seen


awk ' !seen[$0]++' output1mar.txt > allfastas_all_proteins_and_orthologs.txt

cat allfastas_all_proteins_and_orthologs.txt | grep -o "suffix" | wc -l #This shows there are 5000 suffixes


csplit allfastas_all_proteins_and_orthologs.txt '/^>human_/' '{*}'
rm xx00 #This file is empty
mkdir splitfiles
mv xx* splitfiles #Move them all to a new directory

#I made sure that each file has at least 24 lines (which would correspond to 11 specie names + human and 11 FASTA seqs + human FASTA seq
wc -l splitfiles/* | awk '{print $1}' | sort -n | head -10


#Remove suffixes in each file
FILES=splitfiles/*
for f in $FILES; do cat $f | sed 's/_suffix._//g' | sed 's/_suffix.._//g' |sed 's/_suffix..._//g'| sed 's/_suffix...._//g' | sed 's/_suffix....._//g' | sed 's/_suffix......_//g' > $f.suffixless; done

mkdir suffixless
mv splitfiles/*.suffixless suffixless


#Making sure there is no "suffix" in any line of any file
grep -rn 'suffixless' -e 'suffix'

#Rename files
cd suffixless
for fname in xx*; do mv $fname $(head -1 -q $fname|awk '{print $1}'); done
cd ..


#Perform alignment of each file (in two outputs: clustalw and aligned FASTA)
FILES=suffixless/*
for f in $FILES; do muscle3.8.31_i86linux64 -in $f -fastaout $f.afa -clwout $f.aln;done

mkdir fastas
mkdir clustalw

mv suffixless/*.afa fastas
mv suffixless/*.aln clustalw


#Problem Solved :)
