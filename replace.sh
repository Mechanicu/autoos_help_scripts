# !/bin/bash
# 定义要替换的配置项
CONFIGS_TO_DISABLE=(
    "CONFIG_DEBUG_INFO"
    "CONFIG_DEBUG_INFO_BTF"
)
CONFIG_TO_SET_VALUE=(
    "CONFIG_FRAME_WARN"
    "2048" 
)

# 遍历所有配置项
cd config_list
for file in $(ls ./); do
    echo "in $file"
    for config in "${CONFIGS_TO_DISABLE[@]}"; do
        echo "disable $config"
        sed -i "s/^${config}=y/${config}=n/" ${file} 
    done
    for ((i = 0; i < ${#CONFIG_TO_SET_VALUE[@]}; i++)); do
        config=${CONFIG_TO_SET_VALUE[$i]}
        i=$((i + 1))
        val=${CONFIG_TO_SET_VALUE[$i]}
        echo "set value to $val $config"
        sed -i "/${config}/s/=.*/=${val}/" ${file}
    done
done

