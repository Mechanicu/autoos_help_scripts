UNIXBENCH_RES_PATH=/home/unixbench
PREFFIX=debian128
SUFFIX=unixbench

pushd ${UNIXBENCH_RES_PATH}
for file in $(ls ./); do
    version=$(awk -F'--' '/OS:/ {print $2}' ${file} | awk '{print $1}')
    echo "current version=${version}, copy to ${PREFFIX}-${version}-${SUFFIX}"
    cp ${file} ${PREFFIX}-${version}-${SUFFIX}
done
