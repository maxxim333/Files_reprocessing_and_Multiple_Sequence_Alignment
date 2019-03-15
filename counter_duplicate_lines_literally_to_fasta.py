from itertools import islice
outputfile= open("output1mar.txt","w+")


i=0
with open('output28feb_nonewlines.txt') as f:
	for line in f:
		if ">" in line and ">human" in line:
			
			
			outputfile.write(line)
			outputfile.write(next(f, '').strip())
			outputfile.write(next(f, '').strip() + '\n')

			
		if">" in line and ">human" not in line:
			printedline = next(f, '').strip()
			suffixedline = printedline + "_suffix" + str(i) + "_" + "\n"
			outputfile.write(line)
			outputfile.write(suffixedline)
			

			i=i+1
