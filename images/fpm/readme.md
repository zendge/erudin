# 构建指南

## 使用redkoi脚本

安装完redkoi后可以执行以下指令构建

```shell
Build-DockerImage erudin_fpm:25.4
```

## 导出

```shell
docker save <image id> -o ~/tmp/<filename>.tar
```

## 上传

如果上传显示格式不对一直失败，可以进入 https://console.huaweicloud.com/swr/?region=cn-east-2#/swr/warehouse/list/private 在镜像中查看`Pull/Push指南`使用临时登录指令登录后用docker指令上传
