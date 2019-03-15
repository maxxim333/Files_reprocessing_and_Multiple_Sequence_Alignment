# Files_reprocessing_and_Multiple_Sequence_Alignment
Here I perform a iterative MSA (with MUSCLE) on FASTA sequences of many files. The shell script does a bioinformatic reprocessing so the input is correct.

All files are required to be in the same folder. The python script is called from within the shell script and does some reprocessing of the files needed to correct the input.

Explanation:


'''
I have a file with FASTA sequences of human genes and the corresponding orthologs organized in the following way:

\>human_gene_1
AABAABAB
\>specie_1_ortholog_1.1_rep1
AABAABABB
\>specie_2_ortholog_1.2_rep2
ABBAABABB

\>human_gene_2
CDDCDCCDAC
\>specie_1_ortholog_2.1_rep3
CDCCDCACCA
>specie_3_ortholog_2.3_rep4
CCCCCC

\>human_gene_3
ACAABAABBABBA
\>specie_1_ortholog_1.1_rep5
AABAABABB
\>specie_3_ortholog_3.3_rep6
ABBABACBABB
\>specie_4_ortholog_3.4_rep7
ABBABACAAABB
...
...

I want to break down this file into different files so that each file will contain only ONE human protein and all the respective orthologs


Notice that because the orthology also includes 1-to-many relationships, same gene can be ortholog to different human genes (but never vice-versa). This means that there will be repeated FASTA sequences (but not gene name/description lines as each of them has a different suffix (repX)).


'''



python counter_duplicate_lines_literally_to_fasta.py #This script will add a suffix to each NON-HUMAN FASTA sequence.

'''
The output of the python script is in following format:

\>human_gene_1
AABAABAB
\>specie_1_ortholog_1.1_rep1
AABAABABB_s1

\>human_gene_1
AABAABAB
\>specie_2_ortholog_1.2_rep2
ABBAABABB_s2

\>human_gene_2
CDDCDCCDAC
>\specie_1_ortholog_2.1_rep3
CDCCDCACCA_s3

>ºhuman_gene_2
CDDCDCCDAC
>ºspecie_3_ortholog_2.3_rep4
CCCCCC_s4
...
...

I want to convert it to the following format for each file (number of files created will be equal to number of HUMAN genes):
>\human_gene_1
AABAABAB
>\specie_1_ortholog_1.1_rep1
AABAABABB_s1
>\specie_2_ortholog_1.2_rep2
ABBAABABB_s2
'''

All this plus the alignments in ClustalW and Aligned FASTA formats is done by just launching the shell script.
