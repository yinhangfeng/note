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

* 使用容器中的 runner

```
docker run --rm -t -i gitlab/gitlab-runner --help
```


https://docs.gitlab.com/runner/register/index.html

## Predefined environment variables reference
https://docs.gitlab.com/ce/ci/variables/predefined_variables.html
