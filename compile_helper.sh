# !/bin/bash
# config_list=("default" "default-n" "default-s" "default-ns" "autoos-n" "autoos-s" "autoos-ns" "byos-n" "byos-s" "byos-ns")
CONFIG_PATH="/home/config_list"
srctree=${srctree:-"/home/linux-6.1.115"}
config_list=$(ls ${CONFIG_PATH}/*)
pushd ${srctree}
for config in ${config_list[@]}; do
	config=${config##*/}
    make -C ${srctree} distclean
	cp ${CONFIG_PATH}/${config} ${srctree}/.config
    config_suffix=$(echo $config | sed 's/config-//')
	echo "Start processing config $config, suffix=${config_suffix}"
	make olddefconfig
    sed -i "5s/.*/EXTRAVERSION = -${config_suffix}/g" Makefile
    echo "Start compiling config $config"
    make -j$(nproc)  2> err_${config_suffix} ||  {
	    echo "Make failed, check the log file: make_$config.log"
	    continue	
	}
    echo "Start installing modules of config $config"
    make INSTALL_MOD_STRIP=1 modules_install 2> err_mins_${config_suffix} || {
        echo "install module failed, check the log file: make_mod_install_$config.log"
	}
    echo "Start installing kernel of config $config"
    make install  2> err_ins_${config_suffix} || {
        echo "install kernel failed, check the log file: make_install_$config.log"
	}
done
popd
