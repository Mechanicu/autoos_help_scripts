LEBENCH_RES_PATH=/home/LEBench4py3
PREFFIX=debian128
SUFFIX=lebench.csv
TARGET_PATH=/home/debian128_0119_res

pushd ${LEBENCH_RES_PATH}
for file in $(ls output*); do
    version=$(echo "$file" | sed 's/^output\.//;s/\.csv$//')
    echo "current version=${version}, copy to ${PREFFIX}-${version}-${SUFFIX}"
    cp ${file} ${TARGET_PATH}/${PREFFIX}-${version}-${SUFFIX}
done
popd
