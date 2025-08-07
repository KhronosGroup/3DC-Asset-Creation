#!/bin/bash
#
# Copyright 2020 The Khronos Group, Inc.
#
# SPDX-License-Identifier: Apache-2.0

# convert-md-pdf - convert Markdown to PDF
# Usage: convert-md-pdf input.md output.pdf
#
# Doc is assumed to have a CC-BY 4.0 license bracketed by HTML comments
#   <!-- Start License -->
#   <!-- End License -->
# This block is replaced by the Khronos proprietary license.

in=$1
out=$2
tmpfile=`mktemp -p . XXXXXX.md`

# Replace CC-BY license with Khronos spec license in temp file
start='-- Start License --'
end='-- End License --'
cp $1 $tmpfile
sed -i -e "/$start/,/$end/{ /$start/{r copyright-spec.md
    }; d}" $tmpfile

# Convert temp file to asciidoctor
pandoc $tmpfile -o $tmpfile.adoc || (rm $tmpfile ; exit 1)

# Convert asciidoctor to PDF
asciidoctor -b pdf -o $2 -r asciidoctor-pdf $tmpfile.adoc || (rm $tmpfile $tmpfile.adoc ; exit 1)

# Clean up
rm $tmpfile $tmpfile.adoc
