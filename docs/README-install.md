# install 使用

ESP-IDF 从 v3.3 开始引入 install.sh 来帮助开发者安装开发所需工具，使得环境搭建得到了极大的简化，但实际安装过程中常出现以下两个问题导致安装速度非常慢：

- 安装过程中会自动下载该版本 IDF 所需的开发工具，如 gcc、openocd 等，但由于部分工具存放在 github（实际上是存储在 amazon 的 S3 上），导致国内的下载速度非常慢。
  > 具体工具链接可参看各个版本 ESP-IDF 下的 tools/tools.json 文件。

- 安装过程中会在 python virtual environment 中使用 pip 安装所需的包，但默认情况下，pip 使用的是国外的官方源，使得安装非常慢。

## 准备工作

为了解决以上提及的第二点问题，可参考 [pip 源配置](https://cloud.tencent.com/developer/article/1601851)进行配置。

如 pip 版本 >= 10.0.0，建议使用以下方式：

```shell
pip --version
pip config set global.index-url http://mirrors.aliyun.com/pypi/simple
pip config set global.trusted-host mirrors.aliyun.com
```

## 使用流程

Note：不要使用 IDF 自带的 install.sh，使用 esp-gitee-tools 内的 install.sh。

- Step 1：

  ```shell
  git clone https://gitee.com/EspressifSystems/esp-gitee-tools.git
  ```

- Step 2：

  可以有两种方式来安装工具。

  - 方式一

    进入 esp-gitee-tools 目录，export install.sh 所在路径，方便后期使用，如：

    ```shell
    cd esp-gitee-tools
    export EGT_PATH=$(pwd)
    ```

    进入 esp-idf 目录执行 install.sh 脚本：

    ```shell
    cd esp-idf
    $EGT_PATH/install.sh
    ```

  - 方式二

    `install.sh` 脚本支持将 ESP-IDF 工程路径作为参数传入，例如：`install.sh PATH_OF_IDF`。

    假如 esp-idf 位于 ~/git/esp32-sdk/esp-idf 目录，可使用以下方式来更新：

    ```shell
    cd esp-gitee-tools
    ./install.sh ~/git/esp32-sdk/esp-idf
    ```

## Tips

- 如果执行脚本过程中由于网络原因异常退出，可以重复执行该脚本。
- 如使用中有任何问题，请提交到 [Issues](https://gitee.com/EspressifSystems/esp-gitee-tools/issues)。