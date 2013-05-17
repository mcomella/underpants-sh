#!/bin/zsh

# TODO: Add headers and format output.
# TODO: Get data for current consultants only (with arg).

DATA_DIR=/admin/consult/data/
FFILE=$DATA_DIR/food-warnings
PFILE=$DATA_DIR/printer-warnings

FTMP=`mktemp`; PTMP=`mktemp`; JOIN_TMP=`mktemp`

# TODO: Move this to a function.
cat $FFILE | cut -f3 -d' ' | sort | uniq -c | sed 's/^\s*//'  > $FTMP
cat $PFILE | cut -f3 -d' ' | sort | uniq -c | sed 's/^\s*//' > $PTMP

# Join with default values of 0 on unjoinable pairs.
join -j 2 $FTMP $PTMP > $JOIN_TMP
for line in "`join -j 2 $FTMP $PTMP -v 1`"; do
  echo $line | awk '{print $1" "$2" "0}' >> $JOIN_TMP
done
for line in "`join -j 2 $FTMP $PTMP -v 2`"; do
  echo $line | awk '{print $1" "0" "$2}' >> $JOIN_TMP
done

# TODO: Sort on arg.
sort -nrk2,2 $JOIN_TMP

rm $FTMP $PTMP $JOIN_TMP
