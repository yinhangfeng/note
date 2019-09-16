https://docs.gitlab.com/ce/ci/quick_start/README.html

https://docs.gitlab.com/ce/ci/yaml/README.html

## Runner

https://docs.gitlab.com/runner

#### 在 docker 容器中运行 runner

https://docs.gitlab.com/runner/install/docker.html

```
docker run -d --name gitlab-runner --restart always \
   -v /srv/gitlab-runner/config:/etc/gitlab-runner \
   -v /var/run/docker.sock:/var/run/docker.sock \
   gitlab/gitlab-runner:latest
```

* 配置文件位置

```
/srv/gitlab-runner/config/config.toml
```

* 使用容器中的 runner

```
docker run --rm -t -i gitlab/gitlab-runner --help
```
#### 注册

https://docs.gitlab.com/runner/register/index.html

#### 配置

https://docs.gitlab.com/runner/configuration/advanced-configuration.html

#### 在 docker runner 中使用 docker 命令

https://docs.gitlab.com/ce/ci/docker/using_docker_build.html#use-docker-socket-binding

## Predefined environment variables reference
https://docs.gitlab.com/ce/ci/variables/predefined_variables.html
