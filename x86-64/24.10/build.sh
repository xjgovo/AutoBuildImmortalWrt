#!/bin/bash

echo "编译固件大小为: $PROFILE MB"
echo "Include Docker: $INCLUDE_DOCKER"

# 输出调试信息
echo "$(date '+%Y-%m-%d %H:%M:%S') - 开始编译..."



# 定义所需安装的包列表 下列插件你都可以自行删减
PACKAGES=""
PACKAGES="$PACKAGES curl"
PACKAGES="$PACKAGES luci-i18n-diskman-zh-cn"
PACKAGES="$PACKAGES luci-i18n-firewall-zh-cn"
PACKAGES="$PACKAGES luci-i18n-filebrowser-zh-cn"
PACKAGES="$PACKAGES luci-app-argon-config"
PACKAGES="$PACKAGES luci-i18n-argon-config-zh-cn"
#24.10
PACKAGES="$PACKAGES luci-i18n-package-manager-zh-cn"
PACKAGES="$PACKAGES luci-i18n-ttyd-zh-cn"
PACKAGES="$PACKAGES luci-i18n-passwall-zh-cn"
PACKAGES="$PACKAGES luci-app-openclash"
PACKAGES="$PACKAGES luci-i18n-homeproxy-zh-cn"
PACKAGES="$PACKAGES openssh-sftp-server"
# 增加几个必备组件 方便用户安装iStore
PACKAGES="$PACKAGES fdisk"
PACKAGES="$PACKAGES script-utils"
PACKAGES="$PACKAGES luci-i18n-samba4-zh-cn"
PACKAGES="$PACKAGES luci-app-store"
PACKAGES="$PACKAGES luci-app-quickstart"
PACKAGES="$PACKAGES luci-app-design-config"
PACKAGES="$PACKAGES luci-app-argon-config"
PACKAGES="$PACKAGES luci-app-passwall"
PACKAGES="$PACKAGES luci-app-passwall2"
PACKAGES="$PACKAGES luci-app-bypass"
PACKAGES="$PACKAGES luci-app-nikki"
PACKAGES="$PACKAGES luci-app-smartdns"
PACKAGES="$PACKAGES luci-app-mosdns"
PACKAGES="$PACKAGES luci-app-netspeedtest"
PACKAGES="$PACKAGES luci-app-bandwidthd"
PACKAGES="$PACKAGES luci-app-oaf"
PACKAGES="$PACKAGES luci-app-nlbwmon"
PACKAGES="$PACKAGES luci-theme-argon"
PACKAGES="$PACKAGES luci-theme-design"
PACKAGES="$PACKAGES luci-theme-edge"
PACKAGES="$PACKAGES luci-theme-neobird"
PACKAGES="$PACKAGES luci-theme-material"
PACKAGES="$PACKAGES luci-theme-atmaterial"
PACKAGES="$PACKAGES luci-theme-rosy"
PACKAGES="$PACKAGES luci-theme-netgear"
PACKAGES="$PACKAGES luci-theme-opentopd"


# 判断是否需要编译 Docker 插件
if [ "$INCLUDE_DOCKER" = "yes" ]; then
    PACKAGES="$PACKAGES luci-i18n-dockerman-zh-cn"
    echo "Adding package: luci-i18n-dockerman-zh-cn"
fi

# 构建镜像
echo "$(date '+%Y-%m-%d %H:%M:%S') - Building image with the following packages:"
echo "$PACKAGES"

make image PROFILE="generic" PACKAGES="$PACKAGES" FILES="/home/build/immortalwrt/files" ROOTFS_PARTSIZE=$PROFILE

if [ $? -ne 0 ]; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Error: Build failed!"
    exit 1
fi

echo "$(date '+%Y-%m-%d %H:%M:%S') - Build completed successfully."
