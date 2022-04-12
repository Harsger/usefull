pdfname=$1
pngname=${pdfname%.pdf}.png

convert -density 150 -trim ${pdfname} -quality 100 ${pngname}
