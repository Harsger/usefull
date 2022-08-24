pdfname=$1

pngname=${pdfname%.pdf}
pdftoppm -png -cropbox -singlefile -r 300 ${pdfname} ${pngname}

#pngname=${pdfname%.pdf}.png
#convert -density 150 -trim ${pdfname} -quality 100 ${pngname}
