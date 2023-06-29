#!/usr/bin/env bash

# This script is used to run Prisma Cloud Code Security using Checkov CLI in a pre-receive hook.

# Use the prisma api url and key pair for your tenant
PRISMA_API_URL='https://api.prismacloud.io'
BC_API_KEY='<access_key_id>::<secret_access_key>'

# Current repository name may be available as an environment variable depending on the SCM. 
# Check documentation for your specific provider. 
REPO_ID='org/repo'

CHECKOV_COMMAND='checkov -d'

# required flags
CHECKOV_FLAGS="--skip-results-upload --repo-id ${REPO_ID} --prisma-api-url ${PRISMA_API_URL} --bc-api-key ${BC_API_KEY}" 

# add other, optional flags https://www.checkov.io/2.Basics/CLI%20Command%20Reference.html
CHECKOV_OPTIONAL_FLAGS='--framework secrets terraform sca_package  --enable-secret-scan-all-files --compact'

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
${CHECKOV_COMMAND} ${TEMPDIR} ${CHECKOV_FLAGS} ${CHECKOV_OPTIONAL_FLAGS}
exit_code=$?

# cleanup
rm -rf ${TEMPDIR} &> /dev/null

exit $exit_code
