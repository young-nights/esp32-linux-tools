# jihu-mirror 使用

为了解决国内开发者从 github 克隆 esp 相关仓库慢的问题，已将 esp-idf 和部分重要仓库及其关联的子模块镜像到了 [jihu](https://jihulab.com/esp-mirror)，这些仓库将自动从原始仓库进行同步。

> 没有镜像到 gitee 的原因为 gitee 非企业账户不支持占用空间大的仓库。

## 基本原理

git 支持使用类似如下命令将仓库的 URL 进行替换：

```
git config --global url.https://jihulab.com/esp-mirror/espressif/esp-idf.insteadOf https://github.com/espressif/esp-idf
```

当我们使用命令 `git clone https://github.com/espressif/esp-idf` 时，默认的 URL `https://github.com/espressif/esp-idf` 将被自动替换成 `https://jihulab.com/esp-mirror/espressif/esp-idf`。

## 使用流程

可以使用命令 `./jihu-mirror.sh set` 使用镜像的 URL。

可以使用命令 `./jihu-mirror.sh unset` 恢复，不使用镜像的 URL。

当使用镜像 URL 之后，可以任意 clone 位于 github 上的默认仓库，如：

```shell
git clone --recursive https://github.com/espressif/esp-idf.git
git clone --recursive https://github.com/espressif/esp-matter.git
```

## 注意

- 使用了 jihu-mirror 之后，可以不用再使用 submodule-update。
- 如使用中有任何问题或需要镜像其他仓库，请提交到 [Issues](https://gitee.com/EspressifSystems/esp-gitee-tools/issues)。