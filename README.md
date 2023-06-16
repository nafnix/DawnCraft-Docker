# 使用 Docker 创建 DawnCraft 服务器

## 参考项目

- [GitHub - nafnix/RLCraftDocker: Docker 中创建一个 RLCraft 服务器](https://github.com/nafnix/RLCraftDocker)

## 环境要求

至少 8G 的空余内存（如果只是一两个人玩的话也许可以少点。）

## 快速开始

### 拉取镜像并启动容器

复制下面这条命令在你的终端里粘贴就 ok。

```sh
docker run -dit \
           -p 25565:25565 \
           -e EULA=true \
           -v mc-dawncraft-world:/mc/world \
           --name mc-dawncraft \
           nafnix/dawncraft-server
```

#### 参数解释（不想了解可以不看）

- `-dit`: 在后台以交互方式创建一个 tty 终端启动该容器
- `-p 25565:25565`:
  - `-p`: 指定端口映射
  - `25565:25565`: 主机端口对应容器内端口
- `-e EULA=true`:
  - `-e`: 指定环境变量
  - `EULA=true`: 表示同意 [MINECRAFT END USER LICENSE AGREEMENT](https://www.minecraft.net/en-us/eula)。
- `-v mc-dawncraft-world:/mc/world`:
  - `-v`: 表示使用卷备份后面的参数值。
  - `mc-dawncraft-world:/mc/world`: 表示使用或者创建一个名为 `mc-dawncraft-world` 的卷，这个卷连接到容器里的 `/mc/world` 目录。如果后续容器异常或是怎么的无法启动了，可以指定这个选项来使用相同的地图。
- `--name mc-dawncraft`:
  - `--name`: 指定容器名称
  - `mc-dawncraft`: 指定容器名称为 `mc-dawncraft`
- `nafnix/dawncraft-server`: 要运行的镜像名称

### 停止容器

```sh
docker stop mc-dawncraft
```

### 删除容器

```sh
docker rm mc-dawncraft
```

### 删除镜像

```sh
docker rmi nafnix/dawncraft-server
```

### 删除地图备份

```sh
docker volume rm mc-dawncraft-world
```

## 环境变量

### 同意用户协议: `EULA`

在前面已经介绍过一个必要的环境变量：`EULA`，他的值只能是 `true`，以确保你同意 [MINECRAFT END USER LICENSE AGREEMENT](https://www.minecraft.net/en-us/eula)。

使用示例:

```sh
docker run -dit \
           -p 25565:25565 \
           -e EULA=true \
           -v mc-dawncraft-world:/mc/world \
           --name mc-dawncraft \
           nafnix/dawncraft-server
```

### 指定内存大小: `XMS` 与 `XMX`

用途: 指定 jvm 内存大小

| 变量名 | 值       | 作用                 | 默认值 |
| ------ | -------- | -------------------- | ------ |
| `XMS`  | 内存空间 | 设置最小运行占用内存 | `2500M`|
| `XMX`  | 内存空间 | 设置最大运行占用内存 | `8G`   |

如果你没有 8G 的空余内存，可能只有个 5G 或 6G，那么可以像下面这样启动：

```sh
docker run -dit \
           -p 25565:25565 \
           -e EULA=true \
           -e XMX=5G \
           -v mc-dawncraft-world:/mc/world \
           --name mc-dawncraft \
           nafnix/dawncraft-server
```

## 不同标签说明

### 结尾带有 `-nc` 的标签

结尾带有 `-nc` 的标签会在运行时才下载并初始化服务端整合包。

优点:

- 节约镜像空间

缺点:

- 每次运行时都要重新下载并初始化整个服务端整合包。

如果啥也不懂，建议用默认的。
