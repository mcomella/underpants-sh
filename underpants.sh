#!/bin/zsh

# TODO: Add headers and format output.
# TODO: Get data for current consultants only (with arg).

DATA_DIR=/admin/consult/data/
FFILE=$DATA_DIR/food-warnings
PFILE=$DATA_DIR/printer-warnings

function get_count_into_tmp {
  cut --fields=3 --delimiter=' ' $1 | sort | uniq --count | sed 's/^\s*//' > $2
}

FTMP=`mktemp`; PTMP=`mktemp`; JOIN_TMP=`mktemp`
get_count_into_tmp $FFILE $FTMP
get_count_into_tmp $PFILE $PTMP

# Join with default values of 0 on unjoinable pairs.
join -j 2 $FTMP $PTMP > $JOIN_TMP
for line in "`join -j 2 $FTMP $PTMP -v 1`"; do
  echo $line | awk '{print $1" "$2" "0}' >> $JOIN_TMP
done
for line in "`join -j 2 $FTMP $PTMP -v 2`"; do
  echo $line | awk '{print $1" "0" "$2}' >> $JOIN_TMP
done

# TODO: Sort on arg.
sort --numeric-sort --reverse --key=2,2 $JOIN_TMP

rm $FTMP $PTMP $JOIN_TMP
