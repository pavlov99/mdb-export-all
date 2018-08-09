#!/usr/bin/env bash
# Usage: mdb-export-all.sh full-path-to-db

command -v mdb-tables >/dev/null 2>&1 || {
    echo >&2 "I require mdb-tables but it's not installed. Aborting.";
    exit 1;
}

command -v mdb-export >/dev/null 2>&1 || {
    echo >&2 "I require mdb-export but it's not installed. Aborting.";
    exit 1;
}

fullfilename=$1
filename=$(basename "$fullfilename")
dbname=${filename%.*}

mkdir "$dbname"

IFS=$'\n'
for table in $(mdb-tables -1 "$fullfilename"); do
    echo "Export table $table"
    mdb-export "$fullfilename" "$table" > "$dbname/$table.csv"
done
