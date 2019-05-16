
#### 缓存

有时候碰到莫名其妙的错误 比如 pod 依赖了某个库但是找不到文件 则有可能是缓存出问题了 可以删除某个库的缓存试试

列出本地所有缓存
```
pod cache list
```

清除某个缓存
```
pod cache clean xxx
```

清除所有缓存
```
pod cache clean --all
```
