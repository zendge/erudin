#!/usr/bin/env fish
docker build -t erudin_zts:25.6 (dirname (status -f))/.

# 完成后导出 docker save <image id> -o ~/tmp/<filename>.tar
# 如果上传显示格式不对一直失败，可以进入 https://console.huaweicloud.com/swr/?region=cn-east-2#/swr/warehouse/list/private
# 在镜像中查看 Pull/Push指南 使用临时登录指令登录后用docker指令上传
