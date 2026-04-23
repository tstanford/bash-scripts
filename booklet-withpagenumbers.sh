 #!/bin/bash

resizedFile="$1"

#resize to a4 if the input file is letter
if pdfinfo "$1" | grep -qi "letter"; then
  pdfjam "$1" \
    --paper a4paper \
    --scale 0.95 \
    --outfile "a4-$1"
  resizedFile="a4-$1"
fi

#add page numbers to each page
pdfjam "$resizedFile" \
  --pagecommand '{}' \
  --preamble '\setlength{\footskip}{80pt}\pagestyle{plain}' \
  --outfile "numbered-$1"

#convert the numbers pdf to a booklet
pdfjam "numbered-$1" \
 --booklet true \
 --paper a4paper \
 --landscape \
 --outfile "booklet-$1"

#cleanup
rm -f "a4-$1"
rm -f "numbered-$1"
