#!/bin/bash

# 脚本名称: dockerr.sh
# ©️West2Cloud West2Cloud原创脚本，改版权司马
# QQ交流群：255192313

set -e  # 当任何命令返回非零状态时，脚本将退出

# 函数: 输出错误信息并退出
error_exit() {
    echo "错误: $1" >&2
    exit 1
}

# 检查是否以root用户运行
if [[ "$EUID" -ne 0 ]]; then
    error_exit "请使用root用户或使用sudo运行此脚本。"
fi

# 获取操作系统ID和版本
OS_ID=$(awk -F= '/^ID=/{print $2}' /etc/os-release | tr -d '"')
OS_VERSION=$(awk -F= '/^VERSION_ID=/{print $2}' /etc/os-release | tr -d '"')

echo "检测到操作系统: $OS_ID, 版本: $OS_VERSION"

case "$OS_ID" in
    ubuntu|debian)
        echo "正在为Debian/Ubuntu系统配置Docker..."

        # 更新包索引
        apt-get update || error_exit "更新包索引失败。"

        # 安装必要的包以允许apt通过HTTPS使用仓库
        apt-get install -y \
            ca-certificates \
            curl \
            gnupg \
            lsb-release || error_exit "安装必要包失败。"

        # 添加Docker的官方GPG密钥
        mkdir -p /etc/apt/keyrings
        curl -fsSL https://download.docker.com/linux/$OS_ID/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg || error_exit "添加Docker GPG密钥失败。"

        # 设置Docker仓库
        echo \
          "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/$OS_ID \
          $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null || error_exit "设置Docker仓库失败。"

        # 更新包索引
        apt-get update || error_exit "更新包索引失败。"

        # 安装最新版本的Docker Engine, containerd, 和 Docker Compose
        apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin || error_exit "安装Docker失败。"

        # 启动并设置Docker开机自启
        systemctl start docker || error_exit "启动Docker失败。"
        systemctl enable docker || error_exit "设置Docker开机自启失败。"

        # 添加当前用户到docker组（可选）
        if [ -n "$SUDO_USER" ]; then
            usermod -aG docker "$SUDO_USER" || echo "警告: 无法将用户$SUDO_USER添加到docker组。请手动执行。"
        fi

        echo "Docker已成功安装。"
        ;;

    centos|fedora|rhel)
        echo "正在为CentOS/Fedora/RHEL系统配置Docker..."

        # 安装必要的包
        if [[ "$OS_ID" == "fedora" ]]; then
            dnf install -y dnf-plugins-core || error_exit "安装dnf-plugins-core失败。"
            dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo || error_exit "添加Docker仓库失败。"
        else
            yum install -y yum-utils || error_exit "安装yum-utils失败。"
            yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo || error_exit "添加Docker仓库失败。"
        fi

        # 安装Docker Engine, containerd, 和 Docker Compose
        if [[ "$OS_ID" == "fedora" ]]; then
            dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin || error_exit "安装Docker失败。"
        else
            yum install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin || error_exit "安装Docker失败。"
        fi

        # 启动并设置Docker开机自启
        systemctl start docker || error_exit "启动Docker失败。"
        systemctl enable docker || error_exit "设置Docker开机自启失败。"

        # 添加当前用户到docker组（可选）
        if [ -n "$SUDO_USER" ]; then
            usermod -aG docker "$SUDO_USER" || echo "警告: 无法将用户$SUDO_USER添加到docker组。请手动执行。"
        fi

        echo "Docker已成功安装。"
        ;;

    *)
        error_exit "不支持的操作系统: $OS_ID。请手动安装Docker。"
        ;;
esac

echo "Docker安装完成。你可以通过运行 'docker --version' 来验证安装。"