#!/usr/bin/env bash

# This script is used to run checkov in a pre-receive hook

CHECKOV_COMMAND='checkov -d'
TEMPDIR=`mktemp -d`

oldrev=$1
newrev=$2
refname=$3

while read oldrev newrev refname; do
    
    # get list of changed files 
    files=`git diff --name-only ${oldrev} ${newrev}`

    # get list of objects to check
    objects=`git ls-tree --full-name -r ${newrev}`

    for file in ${files}; do
        object=`echo -e "${objects}" | egrep "(\s)${file}\$" | awk '{ print $3 }'`

        if [ -z ${object} ]; 
        then 
            continue; 
        fi

        mkdir -p "${TEMPDIR}/`dirname ${file}`" &>/dev/null
        git cat-file blob ${object} > ${TEMPDIR}/${file}

    done;
done

# run checkov
${CHECKOV_COMMAND} ${TEMPDIR} 
exit_code=$?

# cleanup
rm -rf ${TEMPDIR} &> /dev/null

exit $exit_code