#!/bin/sh
root=$(dirname $0)
cd ${root}/
doc=./doc
categories=$(command ls -d ${doc}/*)


# create main index file
main_index_file=${doc}/index.md
echo "# Cook Index\n" > ${main_index_file}

for category in ${categories}; do
    if [ ! -d ${category} ]; then
        continue
    fi
    name=$(basename ${category})
    echo "Processing category: ${category}, ${name}"
    echo "- [${name}](${name}/index.html)" >> ${main_index_file}
done

# create category index files
for category in ${categories}; do
    name=$(basename ${category})
    echo "Processing category: ${category}, ${name}"
    files=$(find ${category} -name "*.md" -not -name "index.md")
    echo "files: ${files}"
    # create category index file
    index_file=${category}/index.md
    echo "# ${name}\n" > ${index_file}
    for file in ${files}; do
        title=$(basename ${file})
        echo "- [${title}](${title})" >> ${index_file}
    done
done

