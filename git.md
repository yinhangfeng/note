https://github.com/521xueweihan/git-tips

#### 基本命令

```
git clone xxx.git
clone 远程版本库，创建本地分支master与远程的 remotes/origin/master 相同

git branch -a
查看所有本地与远程分支

git checkout branch_name
切换到branch_name分支，但只能切换本地分支,切换远程分支会处于HEAD detached状态，所有提交都只在本地有效

git checkout -b branch_name remote_branch_name
创建branch_name本地分支，以remote_branch_name远程分支为基准

git fetch origin或fork的名字
从远程仓库获取新数据
```

#### 对fork仓库的某个分支相关操作

```
github上fork某个项目git clone 到本地
名词
原仓库: 被fork的项目  fork仓库: 我fork的github项目
假设原仓库名字为 XXX

git checkout -b A remotes/XXX/A
切换到原仓库的分支A，并创建本地分支A，本地分支A tracking 原仓库分支A,此时pull 从原仓库拉取  push可直接提交PR

git push origin A
将本地 分支 A提交到我的fork仓库，并在我的fork仓库中创建分支A

git branch --set-upstream-to remotes/origin/A
将当前本地分支A的远程tracking 分支更改为我的fork仓库中的A,以后push 就是默认提交到我的fork仓库中了，可随时使用 --set-upstream-to切换

git fetch XXX
从原仓库fetch新的修改到本地(相应的git fetch origin 则是从我的fork仓库fetch)

git merge XXX/A
将原仓库中A分支的修改合并到本地A分支

处理外相应合并冲突之后...

git push
将从原仓库的A分支的合并结果提交到我的fork仓库
```

#### submodule

```
git submodule add xxx.git path/to/submodule
添加xxx.git 为submodule 放入当前工程的path/to/submodule目录,当前工程的path/to/submodule不能以存在，否则需要先删除
git clone 之后submodule
git submodule init path/to/submodule
git submodule update
submodule 代码就同步了

递归更新所有 submodule
git submodule update --recursive --remote
https://stackoverflow.com/questions/1777854/git-submodules-specify-a-branch-tag
```

#### 创建一个 bare 仓库用于简单的团队同步
```
mkdir test.git
cd test.git
git init —bare

别人通过
git remote add test xxx@xxx:/path/to/test.git
git fetch test
```
