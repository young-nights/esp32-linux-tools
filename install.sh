#!/usr/bin/env bash

set -e
set -u

die() {
    echo "${1:-"Unknown Error"}" 1>&2
    exit 1
}

# 脚本的第一个参数是 ESP-IDF 的根目录，如果未提供，则使用当前目录
IDF_PATH=${1:-"${PWD}"}
# 将 IDF_PATH 转换为绝对路径
IDF_PATH=$(cd ${IDF_PATH} && pwd -P)

# 把前面算好的 IDF_PATH 放进脚本及其所有子进程的环境变量表里，后续任何调用的子命令都能 $IDF_PATH 拿到它
export IDF_PATH

# 检查 tools.json 文件是否存在，不存在则报错
[ -f "${IDF_PATH}/tools/tools.json" ] || die "${IDF_PATH}/tools/tools.json does not exist!"

# 把 tools.json 文件复制一份，重命名为 tools_gitee.json
cp ${IDF_PATH}/tools/tools.json ${IDF_PATH}/tools/tools_gitee.json

# 如果当前系统是 macOS，则使用空字符串作为扩展名，否则使用双引号
if [[ "$OSTYPE" == "darwin"* ]]; then
    extension="\"\""
else
    extension=
fi

# 把 tools_github.json 文件中的 https://github.com/ 替换为 https://dl.espressif.com/github_assets/
sed -i ${extension} 's,"url": "https://github.com/,"url": "https://dl.espressif.com/github_assets/,g' ${IDF_PATH}/tools/tools_gitee.json

# 检查 detect_python.sh 文件是否存在，不存在则报错
if [ -f "${IDF_PATH}/tools/detect_python.sh" ]; then
    # 如果 detect_python.sh 文件存在，则执行它，它会自动检测 Python 解释器，并设置 ESP_PYTHON 环境变量
    echo "Detecting Python interpreter"
    . "${IDF_PATH}/tools/detect_python.sh"

    # 执行 idf_tools.py 脚本，安装 ESP-IDF 工具
    echo "Installing ESP-IDF tools"
    "${ESP_PYTHON}" "${IDF_PATH}/tools/idf_tools.py" --tools-json ${IDF_PATH}/tools/tools_gitee.json install

    echo "Installing Python environment and packages"
    "${ESP_PYTHON}" "${IDF_PATH}/tools/idf_tools.py" install-python-env
else
    echo "Installing ESP-IDF tools"
    ${IDF_PATH}/tools/idf_tools.py --tools-json ${IDF_PATH}/tools/tools_gitee.json install

    echo "Installing Python environment and packages"
    ${IDF_PATH}/tools/idf_tools.py install-python-env
fi

rm ${IDF_PATH}/tools/tools_gitee.json

echo "All done! You can now run:"
echo ""
echo "  . ${IDF_PATH}/export.sh"
echo ""
