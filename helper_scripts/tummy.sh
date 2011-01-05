#!/bin/bash

#
# This is to replace sed:
#   sed -n '600,800p' cisov_bill.pl
#



if [[ ${#@} -ne 3 ]]; then
   cat <<-EOF
      usage: $0 filename startnumber endlinenumber
EOF
   exit 1
fi

sed -n "$2,$3p;$(($3+1))q" "$1"


