# !/bin/bash
BENCH_WRKDIRS=(
    "/home/LEBench4py3/"
    "/home/byte-unixbench/UnixBench/"	
)
BENCH_TEST_CMDS=(
    "python3 run.py"
    "./Run"
)
len=${#BENCH_WRKDIRS[@]}
for ((i=len-1; i>-1; i--)); do
    dir=${BENCH_WRKDIRS[i]}
    cmd=${BENCH_TEST_CMDS[i]}
    if [ -d "$dir" ]; then
        cd "$dir"
        echo "Entering directory: $dir"
        echo "Executing command: $cmd"
        eval "$cmd"
    else
        echo "Directory $dir does not exist."
    fi
done
