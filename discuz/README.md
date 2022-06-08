# discuz
## 功能
1. 更新镜像方便
2. 配置修改: 所有修改都在Dockerfile进行
3. docker-compose方式启动
4. 支持https, 如果要配置https,请去github下载apache配置, ssl可以从这里免费获取https://letsencrypt.org/how-it-works/


## 注意
镜像已经将apache的日志级别设置为crit,如果服务器资源足够,想设置为error的话,将`-e "s|;opcache.log_verbosity_level=1|opcache.log_verbosity_level=0|g" \`从Dockerfile中移除

## docker-compose使用
``` bash
cd discuz
docker-compose up -d
```

## Dockerfile使用
根据自己的情况修改,构建新的对象
``` bash
cd discuz
docker build -t discuz:xxx .
```

## 引用

https://github.com/v7lin/discuz

https://github.com/skyzhou/docker-discuz

## apache配置修改

https://discuz.com/docs/Windows%20%E4%B8%BB%E6%9C%BA.html#apache

## case
### 启动之后,宿主机连接不上mysql?
方案: 设置host,并重启docker服务 `127.0.0.1 kubernetes.docker.internal`