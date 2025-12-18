# submodule-update 使用

为了解决国内开发者从 github 克隆 esp 相关仓库慢的问题，已将 esp-idf 和部分重要仓库及其关联的子模块镜像到了 gitee。

有部分 esp 仓库会使用 submodules，而 submodules 会指向 github 或者以相对路径的方式指向 gitee 上不存在或不正确的仓库，导致 clone 仍旧慢或者会出错，因此引入了新的脚本来解决此问题。

> 判断是否有 submodules 的方法是确认仓库下是否有 .gitmodules 文件。

## 使用流程

以下以 esp-idf 为例说明，其他包含 submodules 的仓库，如 esp-adf 等均可以参考。

[ ESP-IDF Programming Guide](https://docs.espressif.com/projects/esp-idf/en/latest/esp32/get-started/index.html#linux-and-macos) 中默认使用如下命令来克隆 esp-idf：

```shell
git clone --recursive https://github.com/espressif/esp-idf.git
```

git 命令带了 --recursive 参数后会克隆包括子模块在内的所有仓库。

有别于此，在 gitee 中可使用如下流程：

- Step 1：

  ```shell
  git clone https://gitee.com/EspressifSystems/esp-gitee-tools.git
  ```

- Step 2：

  ```shell
  git clone https://gitee.com/EspressifSystems/esp-idf.git
  ```

  > **注意：仅克隆 esp-idf，不包含子模块。**

- Step 3：

  可以有两种方式来更新 submodules。

  - 方式一

    进入 esp-gitee-tools 目录，export submodule-update.sh 所在路径，方便后期使用，如：

    ```shell
    cd esp-gitee-tools
    export EGT_PATH=$(pwd)
    ```

    进入 esp-idf 目录执行 submodule-update.sh 脚本：

    ```shell
    cd esp-idf
    $EGT_PATH/submodule-update.sh
    ```

  - 方式二

    `submodule-update.sh` 脚本支持将待更新 submodules 的工程路径作为参数传入，例如：`submodule-update.sh PATH_OF_PROJ`。

    假如 Step 2 中 clone 的 esp-idf 位于 ~/git/esp32-sdk/esp-idf 目录，可使用以下方式来更新：

    ```shell
    cd esp-gitee-tools
    ./submodule-update.sh ~/git/esp32-sdk/esp-idf
    ```

    如果要更新其他工程，可以同样方式。

## Tips

- 如果仓库中的 submodules 没有增加或减少，在使用过该脚本的工程内需要对仓库进行更新的情况下，无需一定要再次执行该脚本，可以使用标准的 git 命令，如 `git pull && git submodule update --init --recursive` 来更新，当然要再次使用该脚本也是没有问题的。
- 如果要切换版本，由于不同版本包含的 submodules 可能不同，建议切换版本后再次执行该脚本。
- 如果执行脚本过程中由于网络原因异常退出，可以重复执行该脚本。
- 如使用中有任何问题，请提交到 [Issues](https://gitee.com/EspressifSystems/esp-gitee-tools/issues)。