#!/bin/bash

# 下载链接
URL="https://github.com/Utuobw/Linux-toolbox/blob/main/west2cloud"

# 文件名
OUTPUT_FILE="west2cloud"

# 目标目录
TARGET_DIR="/usr/bin"

# 目标路径
TARGET_PATH="$TARGET_DIR/$OUTPUT_FILE"

# 检查权限
if [ "$(id -u)" -ne 0 ]; then
    echo "错误"
    exit 1
fi

# 下载文件
curl -s -L -o "$TARGET_PATH" "$URL"

# 检查安装
if [ $? -eq 0 ]; then
    # 赋予执行权限
    chmod +x "$TARGET_PATH"
else
    echo "安装失败"
    exit 1
fi