#!/bin/bash
#
# Copyright 2012 Markus Pielmeier
#
# This file is part of batl.
#
# batl utils is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# batl is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with batl.  If not, see <http://www.gnu.org/licenses/>.
#

set -e

IN=$1
OUT=$2

fail() {
    echo "$1" >&2
    exit 1
}

if [ ! -e "$IN" ]
then
    fail "Missing input file: $IN"
fi

if [ -z "$OUT" ]
then
    fail "Missing output file"
fi

cp "$IN" "$OUT"

while read includeExpr
do
    includePath=`echo "$includeExpr" | sed 's/${\(.*\)}/\1/'`

    if [ ! -e "$includePath" ]
    then
	fail "Can't include file: $includePath"
    fi

    replace "$includeExpr" "`cat "$includePath"`" < "$OUT" > "$OUT.tmp"
    mv "$OUT.tmp" "$OUT"
done < <(grep -o '${[^}]*}' "$IN")
