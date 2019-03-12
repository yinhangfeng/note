```
配置文件位置
/etc/gitlab/gitlab.rb
默认备份文件位置
/var/opt/gitlab/backups

修改配置之后执行 gitlab-ctl reconfigure 使配置生效

nginx 配置
https://docs.gitlab.com/omnibus/settings/nginx.html
https://gitlab.com/gitlab-org/gitlab-recipes/tree/master/web-server/nginx
nginx /etc/nginx/conf.d/ 文件夹中的名字需要简单一些 如gitlab.conf 直接为gitlab-omnibus-nginx.conf 好像不行

修改Repository 存储位置
https://stackoverflow.com/questions/19902417/change-the-data-directory-gitlab-to-store-repos-elsewhere
https://gitlab.com/help/administration/repository_storage_paths.md
https://docs.gitlab.com/ee/administration/operations/moving_repositories.html#the-target-directory-contains-an-outdated-copy-of-the-repositories-use-rsync

升级
http://docs.gitlab.cogitlm/omnibus/update/README.html

备份/恢复
sudo gitlab-rake gitlab:backup:create 
https://docs.gitlab.com/ee/raketasks/backup_restore.html
https://gitlab.com/gitlab-org/omnibus-gitlab/blob/master/doc/settings/backups.md#backup-and-restore-omnibus-gitlab-configuration

检查各种状态
https://docs.gitlab.com/omnibus/update/README.html#troubleshooting
gitlab-rake gitlab:check SANITIZE=true

查看版本
gitlab-rake gitlab:env:info
https://stackoverflow.com/questions/21068773/how-to-check-the-version-of-gitlab

Import bare repositories into your GitLab instance  (没成功 创建的repo 为空)
https://docs.gitlab.com/ce/raketasks/import.html

GitLab Prometheus 一般不需要可关闭
https://docs.gitlab.com/ce/administration/monitoring/prometheus/index.html

如果 gitlab 不是独立部署 为防止占用太多资源需要配置 unicorn workers 数量
https://docs.gitlab.com/omnibus/settings/unicorn.html

查看备份文件的版本号
https://stackoverflow.com/questions/26035262/how-to-find-version-of-gitlab-backup
```
