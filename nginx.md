
## centos7 安装

https://nginx.org/en/linux_packages.html#RHEL-CentOS

https://www.cyberciti.biz/faq/how-to-install-and-use-nginx-on-centos-7-rhel-7/

## 使用

#### 检查配置文件

```shell
nginx -t
```

#### 重新加载

```shell
nginx -s reload
```

#### systemctl

```
sudo systemctl enable nginx

sudo systemctl start nginx
```

## 配置

#### gzip

https://juejin.im/post/5b518d1a6fb9a04fe548e8fc

#### https

http://nginx.org/en/docs/http/configuring_https_servers.html
https://help.aliyun.com/knowledge_detail/95491.html

letsencrypt https://github.com/Neilpang/acme.sh

#### http2

http://nginx.org/en/docs/http/ngx_http_v2_module.html


## Error

* Failed to read PID from file /run/nginx.pid: Invalid argument

https://stackoverflow.com/questions/42078674/nginx-service-failed-to-read-pid-from-file-run-nginx-pid-invalid-argument

