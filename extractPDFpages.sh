infile=$1
startPage=$2
endPage=$3
outfile=$4

gs -sDEVICE=pdfwrite -dNOPAUSE -dBATCH -dSAFER -dFirstPage=${startPage} -dLastPage=${endPage} -sOutputFile=${outfile} ${infile}
