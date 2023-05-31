#!/usr/bin/env sh

set -e

if [ "${EULA}" = "true" ]; then
    echo "eula=${EULA}" >eula.txt
else
    echo "必须指定 -e EULA=true 表示同意 https://www.minecraft.net/en-us/eula 上面的最终用户许可协议才可以继续运行"
    exit 1
fi

cat <<'EOF' >user_jvm_args.txt
-XX:+UseG1GC
-XX:+ParallelRefProcEnabled
-XX:MaxGCPauseMillis=200
-XX:+UnlockExperimentalVMOptions
-XX:+DisableExplicitGC
-XX:+AlwaysPreTouch
-XX:G1NewSizePercent=30
-XX:G1MaxNewSizePercent=40
-XX:G1HeapRegionSize=32M
-XX:G1ReservePercent=20
-XX:G1HeapWastePercent=5
-XX:G1MixedGCCountTarget=4
-XX:InitiatingHeapOccupancyPercent=15
-XX:G1MixedGCLiveThresholdPercent=90
-XX:G1RSetUpdatingPauseTimePercent=5
-XX:SurvivorRatio=32
-XX:+PerfDisableSharedMem
-XX:MaxTenuringThreshold=1
-Dusing.aikars.flags=https://mcflags.emc.gs
-Daikars.new.flags=true
EOF

echo '-Xms'${XMS} >>user_jvm_args.txt
echo '-Xmx'${XMX} >>user_jvm_args.txt

exec "$@"
